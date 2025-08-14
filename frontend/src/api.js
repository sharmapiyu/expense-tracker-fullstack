const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:8080';

export async function post(path, body, token) {
  const res = await fetch(API_BASE + path, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { 'Authorization': `Bearer ${token}` } : {})
    },
    body: JSON.stringify(body)
  });
  return handleResponse(res);
}

export async function get(path, token) {
  const res = await fetch(API_BASE + path, {
    method: 'GET',
    headers: {
      ...(token ? { 'Authorization': `Bearer ${token}` } : {})
    }
  });
  return handleResponse(res);
}

export async function put(path, body, token) {
  const res = await fetch(API_BASE + path, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { 'Authorization': `Bearer ${token}` } : {})
    },
    body: JSON.stringify(body)
  });
  return handleResponse(res);
}

export async function del(path, token) {
  const res = await fetch(API_BASE + path, {
    method: 'DELETE',
    headers: {
      ...(token ? { 'Authorization': `Bearer ${token}` } : {})
    }
  });
  return handleResponse(res);
}

async function handleResponse(res) {
  const text = await res.text();
  try {
    const json = text ? JSON.parse(text) : null;
    if (!res.ok) throw { status: res.status, body: json || text };
    return json;
  } catch (e) {
    if (e instanceof SyntaxError) {
      if (!res.ok) throw { status: res.status, body: text };
      return text;
    }
    throw e;
  }
}

export function saveToken(token) {
  localStorage.setItem('jwt_token', token);
}
export function readToken() {
  return localStorage.getItem('jwt_token');
}
export function removeToken() {
  localStorage.removeItem('jwt_token');
}

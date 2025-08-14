import React, { useState } from 'react'
import { post, saveToken } from '../api'

export default function Login({ onLogin }){
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [err, setErr] = useState(null)
  const [loading, setLoading] = useState(false)

  async function submit(e){
    e.preventDefault()
    setErr(null); setLoading(true)
    try{
      const res = await post('/api/auth/login', { email, password })
      const token = res.token || res
      saveToken(token)
      onLogin(token)
    }catch(err){
      setErr(err?.body?.message || err?.body || 'Login failed')
    }finally{ setLoading(false) }
  }

  return (
    <form onSubmit={submit} className="space-y-3">
      <div>
        <label className="block text-sm">Email</label>
        <input value={email} onChange={e=>setEmail(e.target.value)} className="w-full border p-2 rounded" />
      </div>
      <div>
        <label className="block text-sm">Password</label>
        <input type="password" value={password} onChange={e=>setPassword(e.target.value)} className="w-full border p-2 rounded" />
      </div>
      {err && <div className="text-red-600">{err}</div>}
      <button className="w-full bg-blue-600 text-white p-2 rounded" disabled={loading}>{loading ? 'Logging in...' : 'Login'}</button>
    </form>
  )
}

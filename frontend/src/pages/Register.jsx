import React, { useState } from 'react'
import { post } from '../api'

export default function Register(){
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [msg, setMsg] = useState(null)

  async function submit(e){
    e.preventDefault()
    setMsg(null)
    try{
      const res = await post('/api/auth/register', { email, password })
      setMsg('Registered — you can now login')
    }catch(err){
      setMsg('Registration failed: ' + (err?.body || err?.status || 'error'))
    }
  }

  return (
    <form onSubmit={submit} className="space-y-3">
      <h3 className="font-semibold">Register</h3>
      <input value={email} onChange={e=>setEmail(e.target.value)} placeholder="email" className="w-full border p-2 rounded" />
      <input type="password" value={password} onChange={e=>setPassword(e.target.value)} placeholder="password" className="w-full border p-2 rounded" />
      {msg && <div className="text-sm mt-1">{msg}</div>}
      <button className="w-full bg-green-600 text-white p-2 rounded">Register</button>
    </form>
  )
}

import React, { useState, useEffect } from 'react'
import Login from './pages/Login'
import Register from './pages/Register'
import Dashboard from './pages/Dashboard'
import { readToken, removeToken } from './api'

export default function App(){
  const [token, setToken] = useState(readToken())

  useEffect(()=>{
    setToken(readToken())
  },[])

  function onLogout(){
    removeToken()
    setToken(null)
  }

  if(!token){
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="w-full max-w-md p-6 bg-white rounded shadow">
          <h1 className="text-2xl font-bold mb-4">Expense Tracker</h1>
          <Login onLogin={(t)=>setToken(t)} />
          <hr className="my-4" />
          <Register />
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-slate-50">
      <header className="bg-white shadow">
        <div className="max-w-4xl mx-auto p-4 flex justify-between">
          <h2 className="font-bold">Expense Tracker</h2>
          <div>
            <button onClick={onLogout} className="px-3 py-1 bg-red-500 text-white rounded">Logout</button>
          </div>
        </div>
      </header>
      <main className="max-w-4xl mx-auto p-4">
        <Dashboard token={token} />
      </main>
    </div>
  )
}

import React, { useEffect, useState } from 'react'
import { get, post, put, del, readToken } from '../api'

export default function Dashboard({ token }){
  const [items, setItems] = useState([])
  const [desc, setDesc] = useState('')
  const [amount, setAmount] = useState('')
  const [date, setDate] = useState(new Date().toISOString().slice(0,10))
  const [loading, setLoading] = useState(false)
  const [editingId, setEditingId] = useState(null)
  const [editDesc, setEditDesc] = useState('')
  const [editAmount, setEditAmount] = useState('')
  const [editDate, setEditDate] = useState('')
  const t = token || readToken()

  async function load(){
    try{
      const data = await get('/api/expenses', t)
      setItems(data || [])
    }catch(e){
      console.error(e)
    }
  }

  useEffect(()=>{ load() }, [])

  async function add(e){
    e.preventDefault()
    try{
      await post('/api/expenses', { description: desc, amount: parseFloat(amount), date }, t)
      setDesc(''); setAmount('')
      load()
    }catch(err){ console.error(err) }
  }

  async function updateExpense(id){
    try{
      await put(`/api/expenses/${id}`, { 
        description: editDesc, 
        amount: parseFloat(editAmount), 
        date: editDate 
      }, t)
      setEditingId(null)
      setEditDesc('')
      setEditAmount('')
      setEditDate('')
      load()
    }catch(err){ console.error(err) }
  }

  async function deleteExpense(id){
    if(confirm('Are you sure you want to delete this expense?')){
      try{
        await del(`/api/expenses/${id}`, t)
        load()
      }catch(err){ console.error(err) }
    }
  }

  function startEdit(item){
    setEditingId(item.id)
    setEditDesc(item.description)
    setEditAmount(item.amount.toString())
    setEditDate(item.date)
  }

  function cancelEdit(){
    setEditingId(null)
    setEditDesc('')
    setEditAmount('')
    setEditDate('')
  }

  return (
    <div>
      <div className="bg-white p-4 rounded shadow mb-4">
        <h3 className="font-semibold mb-2">Add Expense</h3>
        <form onSubmit={add} className="grid grid-cols-3 gap-2 items-end">
          <input className="col-span-2 border p-2 rounded" placeholder="description" value={desc} onChange={e=>setDesc(e.target.value)} />
          <input className="border p-2 rounded" placeholder="amount" value={amount} onChange={e=>setAmount(e.target.value)} />
          <input type="date" className="border p-2 rounded col-span-1" value={date} onChange={e=>setDate(e.target.value)} />
          <button className="col-span-3 bg-blue-600 text-white p-2 rounded">Add</button>
        </form>
      </div>

      <div className="bg-white p-4 rounded shadow">
        <h3 className="font-semibold mb-2">Your Expenses</h3>
        {items.length === 0 ? <div>No expenses yet</div> :
          <table className="w-full text-left">
            <thead><tr><th>Description</th><th>Amount</th><th>Date</th><th>Actions</th></tr></thead>
            <tbody>
              {items.map(it => (
                <tr key={it.id}>
                  <td>
                    {editingId === it.id ? (
                      <input 
                        value={editDesc} 
                        onChange={e=>setEditDesc(e.target.value)}
                        className="border p-1 rounded w-full"
                      />
                    ) : (
                      it.description
                    )}
                  </td>
                  <td>
                    {editingId === it.id ? (
                      <input 
                        value={editAmount} 
                        onChange={e=>setEditAmount(e.target.value)}
                        className="border p-1 rounded w-20"
                        type="number"
                        step="0.01"
                      />
                    ) : (
                      `$${it.amount}`
                    )}
                  </td>
                  <td>
                    {editingId === it.id ? (
                      <input 
                        value={editDate} 
                        onChange={e=>setEditDate(e.target.value)}
                        className="border p-1 rounded"
                        type="date"
                      />
                    ) : (
                      it.date
                    )}
                  </td>
                  <td>
                    {editingId === it.id ? (
                      <div className="space-x-2">
                        <button 
                          onClick={() => updateExpense(it.id)}
                          className="px-2 py-1 bg-green-500 text-white rounded text-sm"
                        >
                          Save
                        </button>
                        <button 
                          onClick={cancelEdit}
                          className="px-2 py-1 bg-gray-500 text-white rounded text-sm"
                        >
                          Cancel
                        </button>
                      </div>
                    ) : (
                      <div className="space-x-2">
                        <button 
                          onClick={() => startEdit(it)}
                          className="px-2 py-1 bg-blue-500 text-white rounded text-sm"
                        >
                          Edit
                        </button>
                        <button 
                          onClick={() => deleteExpense(it.id)}
                          className="px-2 py-1 bg-red-500 text-white rounded text-sm"
                        >
                          Delete
                        </button>
                      </div>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        }
      </div>
    </div>
  )
}

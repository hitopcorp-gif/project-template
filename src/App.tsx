import { BrowserRouter, Routes, Route } from 'react-router-dom'

function HomePage() {
  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="text-center">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">
          Project Template
        </h1>
        <p className="text-gray-600 mb-8">
          RULES.md + ARCHITECTURE.md + CI 品質ゲート搭載
        </p>
        <div className="bg-white rounded-lg shadow p-6 max-w-md mx-auto text-left">
          <h2 className="font-semibold text-gray-800 mb-3">セットアップ済み:</h2>
          <ul className="space-y-2 text-sm text-gray-600">
            <li>✅ RULES.md — 開発絶対ルール</li>
            <li>✅ ARCHITECTURE.md — コード構造</li>
            <li>✅ CI quality-gate — 9項目自動チェック</li>
            <li>✅ pre-commit — 行数制限チェック</li>
            <li>✅ Wave チェック — 一括品質検証</li>
            <li>✅ Vitest + Testing Library</li>
            <li>✅ Tailwind CSS v4</li>
            <li>✅ React 19 + TypeScript</li>
          </ul>
        </div>
      </div>
    </div>
  )
}

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
      </Routes>
    </BrowserRouter>
  )
}

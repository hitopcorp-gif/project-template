// ============================================================
// 型定義テンプレート — プロジェクトごとに編集
// ============================================================

/**
 * ユーザー基本型（例）
 * プロジェクトに合わせて修正・追加してください
 */
export interface User {
  id: string
  email: string
  name: string
  role: 'admin' | 'user'
  createdAt: Date
  updatedAt: Date
}

/**
 * API レスポンス汎用型
 */
export interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
}

/**
 * ページネーション型
 */
export interface Pagination {
  page: number
  perPage: number
  total: number
  totalPages: number
}

/**
 * リスト取得レスポンス型
 */
export interface ListResponse<T> {
  items: T[]
  pagination: Pagination
}

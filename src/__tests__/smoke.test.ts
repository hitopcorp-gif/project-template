import { describe, it, expect } from 'vitest'

describe('スモークテスト', () => {
  it('テスト環境が正常に動作する', () => {
    expect(1 + 1).toBe(2)
  })

  it('文字列操作が正常に動作する', () => {
    expect('hello'.toUpperCase()).toBe('HELLO')
  })

  it('配列操作が正常に動作する', () => {
    const arr = [1, 2, 3]
    expect(arr.filter(n => n > 1)).toEqual([2, 3])
  })
})

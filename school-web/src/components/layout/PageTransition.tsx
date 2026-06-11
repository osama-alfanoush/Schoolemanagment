import { useState, useEffect, type ReactNode } from "react"
import { useLocation } from "wouter"

interface Props {
  children: ReactNode
}

export default function PageTransition({ children }: Props) {
  const [location] = useLocation()
  const [visible, setVisible] = useState(true)
  const [key, setKey] = useState(0)

  useEffect(() => {
    setVisible(false)
    const t1 = setTimeout(() => {
      setKey((k) => k + 1)
      setVisible(true)
    }, 50)
    return () => clearTimeout(t1)
  }, [location])

  useEffect(() => {
    setVisible(true)
  }, [])

  return (
    <div
      key={key}
      style={{
        opacity: visible ? 1 : 0,
        transform: visible ? "translateY(0)" : "translateY(8px)",
        transition: "opacity 250ms ease-out, transform 250ms ease-out",
      }}
    >
      {children}
    </div>
  )
}

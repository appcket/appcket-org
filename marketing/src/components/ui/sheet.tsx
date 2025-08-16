"use client";

import * as React from "react";
import { createPortal } from "react-dom";

type SheetContextValue = {
  isOpen: boolean;
  setIsOpen: (open: boolean) => void;
};

const SheetContext = React.createContext<SheetContextValue | undefined>(
  undefined
);

interface SheetProps {
  children: React.ReactNode;
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

export function Sheet({ children, open, onOpenChange }: SheetProps) {
  const [isOpen, setIsOpen] = React.useState(!!open);

  React.useEffect(() => {
    if (open !== undefined) setIsOpen(!!open);
  }, [open]);

  React.useEffect(() => {
    onOpenChange?.(isOpen);
  }, [isOpen, onOpenChange]);

  // Prevent background scrolling when sheet is open
  React.useEffect(() => {
    if (typeof document === "undefined") return;
    const prev = document.body.style.overflow;
    if (isOpen) document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = prev;
    };
  }, [isOpen]);

  const value = React.useMemo(() => ({ isOpen, setIsOpen }), [isOpen]);

  return (
    <SheetContext.Provider value={value}>
      <div>{children}</div>
    </SheetContext.Provider>
  );
}

function useSheet() {
  const ctx = React.useContext(SheetContext);
  if (!ctx) throw new Error("Sheet components must be used within a <Sheet />");
  return ctx;
}

export function SheetTrigger({
  asChild,
  children,
}: {
  asChild?: boolean;
  children: React.ReactNode;
}) {
  const { setIsOpen } = useSheet();

  if (asChild && React.isValidElement(children)) {
    return React.cloneElement(
      children as React.ReactElement,
      {
        ...(children as any).props,
        onClick: (e: any) => {
          (children as any).props.onClick?.(e);
          setIsOpen(true);
        },
      } as any
    );
  }

  return (
    <button type="button" onClick={() => setIsOpen(true)}>
      {children}
    </button>
  );
}

export function SheetContent({
  side = "right",
  className,
  children,
}: {
  side?: "left" | "right" | string;
  className?: string;
  children: React.ReactNode;
}) {
  const { isOpen, setIsOpen } = useSheet();
  // animation state: keep mounted while animating out
  const [mounted, setMounted] = React.useState(isOpen);
  const [closing, setClosing] = React.useState(false);

  React.useEffect(() => {
    if (isOpen) {
      setMounted(true);
      setClosing(false);
    } else if (mounted) {
      // start close animation
      setClosing(true);
      const t = setTimeout(() => {
        setMounted(false);
        setClosing(false);
      }, 300);
      return () => clearTimeout(t);
    }
  }, [isOpen, mounted]);

  if (!mounted) return null;

  if (typeof document === "undefined") return null;

  const panelClosedClass =
    side === "left" ? "-translate-x-full" : "translate-x-full";
  const panelOpenClass = "translate-x-0";
  const panelTransformClass = closing ? panelClosedClass : panelOpenClass;

  const overlayOpacityClass = closing ? "opacity-0" : "opacity-100";

  return createPortal(
    <>
      <div
        className={`fixed inset-0 bg-black/40 z-[60] transition-opacity duration-300 ${overlayOpacityClass}`}
        onClick={() => setIsOpen(false)}
      />
      <aside
        className={`fixed inset-y-0 ${
          side === "left" ? "left-0" : "right-0"
        } z-[70] h-full bg-white dark:bg-gray-900 shadow-xl overflow-y-auto p-6 transform transition-transform duration-300 ${panelTransformClass} ${className}`}
        onClick={e => e.stopPropagation()}
      >
        {children}
      </aside>
    </>,
    document.body
  );
}

export function SheetHeader({
  children,
  className,
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return <header className={className}>{children}</header>;
}

export function SheetTitle({
  className,
  children,
}: {
  className?: string;
  children: React.ReactNode;
}) {
  return <h2 className={className}>{children}</h2>;
}

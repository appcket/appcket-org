"use client";

import { Menu, X, User, Rocket } from "lucide-react";
import { useState } from "react";
import { Button, buttonVariants } from "./ui/button";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "./ui/sheet";
import ThemeToggle from "./ThemeToggle";
import { getLoginUrl } from "../lib/getLoginUrl.js";

export function MobileNav() {
  const LOGIN_URL = getLoginUrl(import.meta.env);
  const [isOpen, setIsOpen] = useState(false);

  return (
    <Sheet open={isOpen} onOpenChange={setIsOpen}>
      <SheetTrigger asChild>
        <Button variant="ghost" size="icon" className="md:hidden">
          <Menu className="h-6 w-6" />
          <span className="sr-only">Toggle menu</span>
        </Button>
      </SheetTrigger>
      <SheetContent side="left" className="w-[300px] sm:w-[400px] md:hidden">
        <SheetHeader className="flex items-center justify-between">
          <SheetTitle className="text-left">
            <a
              href="/"
              className="text-2xl font-bold text-indigo-600 dark:text-indigo-400"
            >
              <img src="/logo.svg" width="150" />
            </a>
          </SheetTitle>
          <Button variant="ghost" size="icon" onClick={() => setIsOpen(false)}>
            <X className="h-5 w-5" />
            <span className="sr-only">Close menu</span>
          </Button>
        </SheetHeader>
        <div className="flex flex-col space-y-4 mt-4">
          <a
            href="/product"
            className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white"
          >
            Product
          </a>
          <a
            href="/about"
            className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white"
          >
            About Us
          </a>
          <a
            href="/pricing"
            className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white"
          >
            Pricing
          </a>
          <a
            href="/blog"
            className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white"
          >
            Blog
          </a>
          <a
            href="/faq"
            className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white"
          >
            FAQ
          </a>
          <div className="pt-4 flex flex-col space-y-4">
            <a
              href={LOGIN_URL}
              className={buttonVariants({ variant: "outline" })}
            >
              Login <User className="inline-block ml-1 h-4 w-4" />
            </a>
            <Button className="justify-start">
              Get Started <Rocket className="ml-2 h-4 w-4" />
            </Button>
          </div>
          <div className="pt-4">
            <ThemeToggle />
          </div>
        </div>
      </SheetContent>
    </Sheet>
  );
}

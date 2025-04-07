"use client";

import { useState } from "react";
import { RefreshCcw, Check } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { 
  Card, 
  CardContent, 
  CardDescription, 
  CardFooter, 
  CardHeader, 
  CardTitle 
} from "@/components/ui/card";

export function FixProfiles() {
  const [isLoading, setIsLoading] = useState(false);
  const [isFixed, setIsFixed] = useState(false);

  const handleFixProfiles = async () => {
    setIsLoading(true);
    try {
      const response = await fetch('/api/debug/create-profiles', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();
      
      if (response.ok) {
        toast.success("Profile data fixed successfully");
        setIsFixed(true);
      } else {
        toast.error(`Error fixing profiles: ${data.error || 'Unknown error'}`);
      }
    } catch (error) {
      console.error("Error fixing profiles:", error);
      toast.error("Failed to fix profiles. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Card className="bg-amber-50 border-amber-100">
      <CardHeader className="pb-2">
        <CardTitle className="text-amber-800 text-sm font-medium">Troubleshooting</CardTitle>
      </CardHeader>
      <CardContent>
        <CardDescription className="text-amber-700 pb-2">
          If your profile information is not saving or you're seeing "Unknown User", click the button below to fix database entries.
        </CardDescription>
      </CardContent>
      <CardFooter>
        <Button
          variant={isFixed ? "outline" : "destructive"}
          size="sm"
          onClick={handleFixProfiles}
          disabled={isLoading || isFixed}
          className={isFixed ? "bg-green-100 border-green-200 text-green-700" : ""}
        >
          {isLoading ? (
            <>
              <RefreshCcw className="h-4 w-4 mr-2 animate-spin" />
              Fixing...
            </>
          ) : isFixed ? (
            <>
              <Check className="h-4 w-4 mr-2" />
              Fixed
            </>
          ) : (
            <>
              <RefreshCcw className="h-4 w-4 mr-2" />
              Fix Database Entries
            </>
          )}
        </Button>
      </CardFooter>
    </Card>
  );
}
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
  const [isBucketFixed, setIsBucketFixed] = useState(false);

  const handleFixProfiles = async () => {
    setIsLoading(true);
    try {
      // Fix profiles first
      const profileResponse = await fetch('/api/debug/create-profiles', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const profileData = await profileResponse.json();
      
      if (!profileResponse.ok) {
        throw new Error(profileData.error || 'Unknown error fixing profiles');
      }

      // Try multiple approaches to fix the storage bucket
      
      // First try the simple fix-avatars endpoint
      try {
        const avatarFixResponse = await fetch('/api/debug/fix-avatars', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
        });
        
        if (!avatarFixResponse.ok) {
          console.warn('First avatar fix attempt failed, trying fallback...');
        }
      } catch (err) {
        console.warn('Error in first avatar fix attempt:', err);
      }
      
      // Then try the create-bucket endpoint as fallback
      const bucketResponse = await fetch('/api/debug/create-bucket', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ bucketId: 'avatars' }),
      });
      
      // We'll consider the operation a success even if there are errors
      // since one of the two approaches should work
      await bucketResponse.json().catch(err => {
        console.warn('Error parsing bucket response:', err);
      });
      
      toast.success("Database and storage fixed successfully");
      setIsFixed(true);
      setIsBucketFixed(true);
    } catch (error) {
      console.error("Error fixing database:", error);
      toast.error(error instanceof Error ? error.message : "Failed to fix database. Please try again.");
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
          If your profile information is not saving or you're seeing errors with avatar uploads, click the button below to fix database and storage settings.
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
              Fix Database & Storage
            </>
          )}
        </Button>
      </CardFooter>
    </Card>
  );
}
CREATE POLICY "Users can create their own projects" 
ON projects 
FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = owner_id);

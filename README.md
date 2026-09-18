# Growth OS — Dynamic Vercel + Supabase

## What this is
A real dynamic personal dashboard. Authentication is via Supabase email magic links. Check-ins, trades, clients and goals are stored in PostgreSQL and are available from any signed-in device.

## Deploy
1. Create a Supabase project.
2. Open Supabase SQL Editor and run `supabase/schema.sql`.
3. In Supabase Authentication > URL Configuration, add your Vercel deployment URL to Site URL / Redirect URLs.
4. Copy the project URL and anon/publishable key.
5. In Vercel, import this project.
6. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
7. Deploy.

## Local
`npm install`
`npm run dev`

## Important
This version uses Supabase RLS so each signed-in user can only access their own records. It is designed for a personal dashboard and does not require a custom server API for basic CRUD.

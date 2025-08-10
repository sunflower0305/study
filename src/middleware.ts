import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Silence missing CSS source map requests from logs with 204
  if (pathname.startsWith('/_next/static/css/') && pathname.endsWith('.css.map')) {
    return new NextResponse(null, { status: 204 });
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/_next/static/css/:path*',
  ],
};

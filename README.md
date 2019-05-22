# MacOS Verification skipper

Not everyone wants to wait for the lengthy "Verifying" process that MacOS goes through every time we run an Application we downloaded. Especially when we know it's from a trusted source, and that it can't possibly be corrupted.

Of course, you could use xattr -d com.apple.quarantine <filename>, which is basically what this application does.

But not everyone wants to open Terminal every time, and not everyone wants to look up the correct attribute every time.

So here's a little convenience application. Not sure if it's needed, but it's certainly useful for me.

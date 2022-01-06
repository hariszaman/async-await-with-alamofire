#AGENDA
## What is Async await and how it is used
## Usage with Alamofire requests


#Key points to remember

##1. When a function is marked as "async". It may or may not suspend 1 or more time. When it suspends it hands over the control to system.

##2. "await" keyword is used for call async functions.

##3. If an async function can throw an error it is marked as "async throws". And is called using "try await".

##4. To switch from sync context to async context Task is used.

##5. When an async function is suspended thread is not blocked.

##6. When the async function execution is finished the result is handed over to the caller of that function.

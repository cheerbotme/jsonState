#! /usr/bin/env node
( new function app() {
	function create( $0, $1 ) {
		$1.statusCode = 200
		; $1.setHeader(
			"Content-Type"
			, "text/html"
		)
		; _0.reread( $1 )
		;
	}
	function listen() {
		console.log(
			"Server running at "
				+ `http://${ _0.hostname }`
				+ `:${ _0.port }`
		)
		;
	}
	function reread( $0 ) {
		const _1 = $0
		; _0.read(
			'./index.html'
			, 'utf8'
			, ( $0, $1 ) => {
				if ( $0 ) {
					console.error( $0 )
					; return
					;
				}
				_1.end( $1 )
				;
			}
		)
		;
	}
	const _0 = new App
	; _0.server = _0.http.createServer( _0.create )
	; _0.server.listen(
		_0.port
		, _0.hostname
		, _0.listen
	)
	;
	function App() {
		this.create = create
		; this.hostname = "127.0.0.1"
		; this.http = require( "http" )
		; this.listen = listen
		; this.port = 3000
		; this.read = require( 'fs' ).readFile
		; this.reread = reread
		; this.server = null
		;
	}
} )
;

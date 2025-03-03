(define-module (gamma-libmeshb)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages commencement))

(define-public gamma-libmeshb
  (package
    (name "gamma-libmeshb")
    (version "7.84")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/LoicMarechal/libMeshb")
              (commit "952a157")))
        (file-name (git-file-name name version))
        (sha256 (base32 "1plms09ki5v9r9q29jhng9b1khn6hyllkqix31hhvs8984zrf2yi"))))
    (inputs (list gfortran))
    (build-system cmake-build-system)
    (arguments
      '(#:tests? #f
        #:build-type "Release"
        #:configure-flags '("-DBUILD_SHARED_LIBS=ON")))
    (home-page "https://github.com/LoicMarechal/libMeshb")
    (synopsis "A library to handle the *.meshb file format")
    (description "The Gamma Mesh Format (GMF) and the associated library libMeshb provide programers of simulation and meshing software with an easy way to store their meshes and physical solutions. The GMF features more than 200 kinds of data types, like vertex, polyhedron, normal vector or vector solution field. The libMeshb provides a convenient way to move data between those files, via keyword tags, and the user's own structures. Transparent handling of ASCII & binary files. Transparent handling of little & big endian files. Optional ultra fast asynchronous and low level transfers. Can call user's own pre and post processing routines in a separate thread while accessing a file.")
    (license license:expat)))

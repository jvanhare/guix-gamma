(define-module (gamma-tetgen)
  #:use-module (guix)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages base)
  #:use-module (guix build-system gnu))

(define-public gamma-tetgen
  (package
    (name "gamma-tetgen")
    (version "1.6.0")
    (source
     (origin
       (method url-fetch)
       (uri
         "https://wias-berlin.de/software/tetgen/1.5/src/tetgen1.6.0.tar.gz")
       (sha256
        (base32 "0fff0l6i3xfjlm0zkcgyyhwndp8i5d615mydyb21yirsplgfddc7"))))
    (build-system gnu-build-system)
    (arguments
        `(#:tests? #f
          #:phases (modify-phases %standard-phases
                    (delete 'configure)

                    (replace 'build
                      (lambda _
                        (invoke "g++" "-O0" "-fPIC" "-c" "predicates.cxx")
                        (invoke "g++" "-O3" "-fPIC" "-o" "tetgen" "tetgen.cxx" "predicates.o" "-lm")
                        (invoke "g++" "-O3" "-fPIC" "-DTETLIBRARY" "-c" "tetgen.cxx")
                        (invoke "ar" "r" "libtet.a" "tetgen.o" "predicates.o")))

                    (replace 'install
                      (lambda* (#:key outputs #:allow-other-keys)
                        (let ((bin-dir (string-append (assoc-ref outputs "out") "/bin")))
                        (mkdir-p bin-dir)
                        (install-file "tetgen" bin-dir))
                        (let ((include-dir (string-append (assoc-ref outputs "out") "/include")))
                        (mkdir-p include-dir)
                        (install-file "tetgen.h" include-dir))
                        (let ((lib-dir (string-append (assoc-ref outputs "out") "/lib")))
                        (mkdir-p lib-dir)
                        (install-file "libtet.a" lib-dir))
                        )))))
    (home-page "https://wias-berlin.de/software/tetgen/")
    (synopsis "Quality Tetrahedral Mesh Generator and 3D Delaunay Triangulator")
    (description
     "TetGen is a program to generate tetrahedral meshes of any 3D
polyhedral domains.  TetGen generates exact constrained Delaunay
tetrahedralizations, boundary conforming Delaunay meshes, and Voronoi
partitions.")
    (license license:agpl3+)))

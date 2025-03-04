(define-module (gamma-parmetis-i64-r64)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system cmake)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages commencement))

(define-public gamma-parmetis-i64-r64
  (package
    (name "gamma-parmetis-i64-r64")
    (version "4.0.3")
    (source
      (origin
        (method url-fetch)
        (uri  "https://github.com/jvanhare/parmetis/archive/refs/tags/v4.0.3.tar.gz")
        (sha256 (base32 "00d4klsz1j9h7i726v9cwf95vkl9vshzk9fx3rdsggc2szn7jvbh"))))
    (inputs (list openmpi))
    (build-system cmake-build-system)
    (arguments
      '(#:tests? #f
        #:build-type "Release"
        #:configure-flags '("-DBUILD_SHARED_LIBS=ON" "-DMETIS_I64=ON" "-DMETIS_R64=ON")))
    (home-page "https://github.com/jvanhare/parmetis")
    (synopsis "Graph partitioning and fill-reducing matrix ordering")
    (description
     "METIS is a set of serial programs for partitioning graphs, partitioning
finite element meshes, and producing fill-reducing orderings for sparse
matrices.  The algorithms implemented in METIS are based on the multilevel
recursive-bisection, multilevel k-way, and multi-constraint partitioning
schemes.")
    (license license:asl2.0)))

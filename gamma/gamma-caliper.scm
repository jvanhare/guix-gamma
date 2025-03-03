(define-module (gamma-caliper)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module ((guix utils)
                #:select (version-major+minor substitute-keyword-arguments))
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  #:use-module (gnu packages base)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages profiling)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages xiph))

(define-public gamma-blt
  (let ((commit "5a792c1775e7a7628d84dcde31652a689f1df7b5")
        (revision "20230605"))
    (package
      (name "gamma-blt")
      (version (git-version "0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/LLNL/blt")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "110xb9ssm5vpq09q83qraqjdg40z58qid2nq67sr8lfk95rf49ym"))))
      (build-system copy-build-system)
      (arguments
       '(#:install-plan '(("." "blt_dir"))))
      (home-page "https://llnl-blt.readthedocs.io/en/develop/")
      (synopsis "CMake macros and tools assembled to simplify HPC software development")
      (description
       "BLT is a streamlined CMake-based foundation for Building, Linking and
Testing large-scale high performance computing (HPC) application.")
      (license license:bsd-3))))


(define-public gamma-adiak
  (package
    (name "gamma-adiak")
    (version "0.2.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference (url "https://github.com/LLNL/adiak")
                                  (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1n0bzibjf1l9pgc5gff5cjsdpgbrnd1wz01ib1jkd672l3zh7w7g"))))
    (build-system cmake-build-system)
    (inputs (list openmpi gamma-blt))
    (arguments
     (list #:configure-flags
           #~`("-DWITH_MPI=ON"
               ,(string-append "-DBLT_SOURCE_DIR="
                               #$(this-package-input "gamma-blt")
                               "/blt_dir")
               "-DBUILD_SHARED_LIBS=ON"
               "-DENABLE_TESTS=ON")))
    (home-page "https://software.llnl.gov/adiak/")
    (synopsis "Collect metadata from HPC application runs")
    (description
     "Adiak is a library for recording meta-data about HPC simulations.  An HPC
application code may, for example, record what user invoked it, the version
of the code being run, a computed time history showing density changes, or
how long the application spent performing file IO.  Adiak represents this
metadata as Name/Value pairs.  Names are arbitrary strings, with some
standardization, and the values are represented by a flexible dynamic type
system")
    (license license:bsd-3)))


(define-public gamma-caliper
  (package
    (name "gamma-caliper")
    (version "2.8.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference (url "https://github.com/LLNL/Caliper")
                                  (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1nbiy1zn6kh9hyjjk2xp2ff7i1ag9nn0ib790mc3lgkpr40zra1q"))))
    (build-system cmake-build-system)
    (inputs (list openmpi gamma-blt gamma-adiak papi python))
    (arguments
     (list #:configure-flags
           #~`("-DWITH_MPI=ON"
               "-DWITH_ADIAK=ON"
               "-DWITH_PAPI=ON"
               ,(string-append "-Dadiak_DIR="
                               #$(this-package-input "gamma-adiak")
                               "/lib/cmake/adiak/")
               "-DBUILD_SHARED_LIBS=ON")
           #:tests? #f))
    (home-page "https://software.llnl.gov/caliper/")
    (synopsis "Performance instrumentation and profiling library")
    (description
     "Caliper is a program instrumentation and performance measurement framework.
It is a performance-analysis toolbox in a library, allowing one to bake
performance analysis capabilities directly into applications and activate
them at runtime.  Caliper is primarily aimed at HPC applications, but works
for any C/C++/Fortran program.")
    (license license:bsd-3)))

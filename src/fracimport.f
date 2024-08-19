C ##############################################################################
C FRACDIFF-fdgam

      double precision function dgamma (x)
c     jan 1984 edition.  w. fullerton, c3, los alamos scientific lab.
C     double precision x, gamcs(42), dxrel, pi, sinpiy, sq2pil, xmax,
C     1  xmin, y, d9lgmc, dcsevl, d1mach, dexp, dint, dlog,
C     2  dsin, dsqrt

      double precision x
      double precision gamcs(42), dxrel, pi, sinpiy, sq2pil, xmax,
     1     xmin, xsml, y, temp
      integer ngam, n, i

      double precision d9lgmc, dcsevl
      integer initds
C     external d1mach, d9lgmc, dcsevl, dexp, dint, dlog, dsin, dsqrt,
C     1  initds
      external d9lgmc, dcsevl, initds

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
c     series for gam        on the interval  0.          to  1.00000e+00
c     with weighted error   5.79e-32
c     log weighted error  31.24
c     significant figures required  30.00
c     decimal places required  32.05
c
      data gamcs(  1) / +.8571195590 9893314219 2006239994 2 d-2      /
      data gamcs(  2) / +.4415381324 8410067571 9131577165 2 d-2      /
      data gamcs(  3) / +.5685043681 5993633786 3266458878 9 d-1      /
      data gamcs(  4) / -.4219835396 4185605010 1250018662 4 d-2      /
      data gamcs(  5) / +.1326808181 2124602205 8400679635 2 d-2      /
      data gamcs(  6) / -.1893024529 7988804325 2394702388 6 d-3      /
      data gamcs(  7) / +.3606925327 4412452565 7808221722 5 d-4      /
      data gamcs(  8) / -.6056761904 4608642184 8554829036 5 d-5      /
      data gamcs(  9) / +.1055829546 3022833447 3182350909 3 d-5      /
      data gamcs( 10) / -.1811967365 5423840482 9185589116 6 d-6      /
      data gamcs( 11) / +.3117724964 7153222777 9025459316 9 d-7      /
      data gamcs( 12) / -.5354219639 0196871408 7408102434 7 d-8      /
      data gamcs( 13) / +.9193275519 8595889468 8778682594 0 d-9      /
      data gamcs( 14) / -.1577941280 2883397617 6742327395 3 d-9      /
      data gamcs( 15) / +.2707980622 9349545432 6654043308 9 d-10     /
      data gamcs( 16) / -.4646818653 8257301440 8166105893 3 d-11     /
      data gamcs( 17) / +.7973350192 0074196564 6076717535 9 d-12     /
      data gamcs( 18) / -.1368078209 8309160257 9949917230 9 d-12     /
      data gamcs( 19) / +.2347319486 5638006572 3347177168 8 d-13     /
      data gamcs( 20) / -.4027432614 9490669327 6657053469 9 d-14     /
      data gamcs( 21) / +.6910051747 3721009121 3833697525 7 d-15     /
      data gamcs( 22) / -.1185584500 2219929070 5238712619 2 d-15     /
      data gamcs( 23) / +.2034148542 4963739552 0102605193 2 d-16     /
      data gamcs( 24) / -.3490054341 7174058492 7401294910 8 d-17     /
      data gamcs( 25) / +.5987993856 4853055671 3505106602 6 d-18     /
      data gamcs( 26) / -.1027378057 8722280744 9006977843 1 d-18     /
      data gamcs( 27) / +.1762702816 0605298249 4275966074 8 d-19     /
      data gamcs( 28) / -.3024320653 7353062609 5877211204 2 d-20     /
      data gamcs( 29) / +.5188914660 2183978397 1783355050 6 d-21     /
      data gamcs( 30) / -.8902770842 4565766924 4925160106 6 d-22     /
      data gamcs( 31) / +.1527474068 4933426022 7459689130 6 d-22     /
      data gamcs( 32) / -.2620731256 1873629002 5732833279 9 d-23     /
      data gamcs( 33) / +.4496464047 8305386703 3104657066 6 d-24     /
      data gamcs( 34) / -.7714712731 3368779117 0390152533 3 d-25     /
      data gamcs( 35) / +.1323635453 1260440364 8657271466 6 d-25     /
      data gamcs( 36) / -.2270999412 9429288167 0231381333 3 d-26     /
      data gamcs( 37) / +.3896418998 0039914493 2081663999 9 d-27     /
      data gamcs( 38) / -.6685198115 1259533277 9212799999 9 d-28     /
      data gamcs( 39) / +.1146998663 1400243843 4761386666 6 d-28     /
      data gamcs( 40) / -.1967938586 3451346772 9510399999 9 d-29     /
      data gamcs( 41) / +.3376448816 5853380903 3489066666 6 d-30     /
      data gamcs( 42) / -.5793070335 7821357846 2549333333 3 d-31     /
c
      data pi / 3.1415926535 8979323846 2643383279 50 d0 /
c     sq2pil is 0.5*alog(2*pi) = alog(sqrt(2*pi))
      data sq2pil / 0.9189385332 0467274178 0329736405 62 d0 /
      data ngam, xmin, xmax, xsml, dxrel / 0, 4*0.d0 /
      dgamma = -999d0
c
      if (ngam.eq.0) then
C        ngam = initds (gamcs, 42, 0.1*sngl(  d1mach) )
         ngam = initds (gamcs, 42, 0.1*sngl(  EPSMIN ) )
c
         call d9gaml (xmin, xmax)
         if (IGAMMA .ne. 0) return
C        xsml = dexp (dmax1 (dlog(d1mach(1)), -dlog(d1mach(2)))+0.01d0)
         xsml =  exp ( max  ( log( FLTMIN  ), - log( FLTMAX  ))+0.01d0)
C        dxrel = dsqrt (d1mach(4))
         dxrel =  sqrt (  EPSMAX )
c
      endif
C     y = dabs(x)
      y =  abs(x)
      if (y .gt. 10.d0) go to 50
c
c     compute gamma(x) for -xbnd .le. x .le. xbnd.  reduce interval and find
c     gamma(1+y) for 0.0 .le. y .lt. 1.0 first of all.
c
      n = int(x)
      if (x.lt.0.d0) n = n - 1
      y = x - dble(float(n))
      n = n - 1
C     dgamma = 0.9375d0 + dcsevl (2.d0*y-1.d0, gamcs, ngam)
      temp = dcsevl (2.d0*y-1.d0, gamcs, ngam)
      if (IGAMMA .ne. 0) return
      dgamma = 0.9375d0 + temp
      if (n.eq.0) return
c
      if (n.gt.0) go to 30
c
c     compute gamma(x) for x .lt. 1.0
c
      n = -n

C     if (x.eq.0.d0) call seteru (14hdgamma  x is 0, 14, 4, 2)
C     if (x.lt.0d0 .and. x+dble(float(n-2)).eq.0.d0) call seteru (
C     1  31hdgamma  x is a negative integer, 31, 4, 2)
C     if (x.lt.(-0.5d0) .and. dabs((x-dint(x-0.5d0))/x).lt.dxrel) call
C     1  seteru (68hdgamma  answer lt half precision because x too near n
C     2egative integer, 68, 1, 1)
C     if (y.lt.xsml) call seteru (
C     1  54hdgamma  x is so close to 0.0 that the result overflows,
C     2  54, 5, 2)

      if (x.eq.0.d0) then
C     write(6,*) 'dgamma : x is 0'
         IGAMMA = 11
         return
      end if

      if (x.lt.0d0 .and. x+dble(float(n-2)).eq.0.d0) then
C     write( 6, *) 'dgamma : x is a negative integer'
         IGAMMA = 12
         return
      end if

      if (x.lt.(-0.5d0) .and. abs((x-dble(int(x-0.5d0)))/x).lt.dxrel)
C     1  write(6,*) 'dgamma : answer lt half precision because
C     2                       x too near a negative integer'
     *     JGAMMA = 11

      if (y.lt.xsml) then
c     write(6,*)  'dgamma :,
c     1               x is so close to 0.0 that the result overflows'
         IGAMMA = 13
         return
      end if
c
      do 20 i=1,n
         dgamma = dgamma/(x+dble(float(i-1)) )
 20   continue
      return
c
c     gamma(x) for x .ge. 2.0 and x .le. 10.0
c
 30   do 40 i=1,n
         dgamma = (y+dble(float(i))) * dgamma
 40   continue
      return
c
c     gamma(x) for dabs(x) .gt. 10.0.  recall y = dabs(x).
c
C50   if (x.gt.xmax) call seteru (32hdgamma  x so big gamma overflows,
C    1  32, 3, 2)

 50   if (x.gt.xmax) then
c     write(6,*) 'dgamma : x so big gamma overflows'
         IGAMMA = 14
         return
      end if
c
      dgamma = 0.d0
C     if (x.lt.xmin) call seteru (35hdgamma  x so small gamma underflows
C     1  , 35, 2, 0)
C     if (x.lt.xmin) return

      if (x.lt.xmin) then
c     write(6,*) 'dgamma : x so small gamma underflows'
         JGAMMA = 12
         return
      end if
c
C     dgamma = dexp ((y-0.5d0)*dlog(y) - y + sq2pil + d9lgmc(y) )
      temp = d9lgmc(y)
      if (IGAMMA .ne. 0) return
      dgamma =  exp ((y-0.5d0)* log(y) - y + sq2pil + temp)
      if (x.gt.0.d0) return
c
C     if (dabs((x-dint(x-0.5d0))/x).lt.dxrel) call seteru (
C     1  61hdgamma  answer lt half precision, x too near negative integer
C     2  , 61, 1, 1)

      if (abs((x-dble(int(x-0.5d0)))/x).lt.dxrel) JGAMMA = 11
c
C     sinpiy = dsin (pi*y)
      sinpiy =  sin (pi*y)
C     if (sinpiy.eq.0.d0) call seteru (
C     1  31hdgamma  x is a negative integer, 31, 4, 2)

      if (sinpiy.eq.0.d0) then
C     write(6,*) 'dgamma : x is a negative integer'
         IGAMMA = 12
         return
      end if
c
      dgamma = -pi/(y*sinpiy*dgamma)
c
      return
      end

      double precision function dgamr (x)
c july 1977 edition.  w. fullerton, c3, los alamos scientific lab.
c this routine, not dgamma(x), should be the fundamental one.
c
C     double precision x, alngx, sgngx, dgamma, dint, dexp, d1mach
      double precision x, alngx, sgngx, temp,  dgamma

C     external dexp, dgamma, dint, d1mach
      external dgamma

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
      dgamr = 0d0
C     if (x.le.0d0 .and. dint(x).eq.x) return
      if (x.le.0d0 .and. dble(int(x)).eq.x) return
c
C     call entsrc (irold, 1)
      if (dabs(x).gt.10d0) go to 10
C     dgamr = 1.0d0/dgamma(x)
C     call erroff
C     call entsrc (ir, irold)
      temp = dgamma(x)
      if (IGAMMA .ne. 0) then
C       dgamr = d1mach(2)
        dgamr = FLTMAX
        return
      end if
      dgamr = 1.0d0/temp
      return
c
 10   call dlgams (x, alngx, sgngx)
      if (IGAMMA .ne. 0) return
C     call erroff
C     call entsrc (ir, irold)
C     dgamr = sgngx * dexp(-alngx)
      dgamr = sgngx *  exp(-alngx)
      return
c
      end

      subroutine dlgams (x, dlgam, sgngam)
c july 1977 edition.  w. fullerton, c3, los alamos scientific lab.
c
c evaluate log abs (gamma(x)) and return the sign of gamma(x) in sgngam.
c sgngam is either +1.0 or -1.0.
c
C     double precision x, dlgam, sgngam, dint, dlngam
      double precision x, dlgam, sgngam, dlngam
      integer intx
C     external dint, dlngam
      external dlngam

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
      dlgam = dlngam(x)
      if (IGAMMA .ne. 0) return
      sgngam = 1.0d0
      if (x.gt.0.d0) return
c
C     int = dmod (-dint(x), 2.0d0) + 0.1d0
C     if (int.eq.0) sgngam = -1.0d0
      intx =  mod (-dble(int(x)), 2.0d0) + 0.1d0
      if (intx.eq.0) sgngam = -1.0d0
c
      return
      end

      integer function initds (dos, nos, eta)
c june 1977 edition.   w. fullerton, c3, los alamos scientific lab.
c
c initialize the double precision orthogonal series dos so that initds
c is the number of terms needed to insure the error is no larger than
c eta.  ordinarily eta will be chosen to be one-tenth machine precision.
c
c             input arguments --
c dos    dble prec array of nos coefficients in an orthogonal series.
c nos    number of coefficients in dos.
c eta    requested accuracy of series.
c
      integer nos
      double precision dos(nos)
      real eta

      integer ii, i
      double precision err

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
C     if (nos.lt.1) call seteru (
C    1  35hinitds  number of coefficients lt 1, 35, 2, 2)
      if (nos.lt.1) JGAMMA = 31
c
      i = -1
      err = 0.
      do 10 ii=1,nos
        i = nos + 1 - ii
        err = err + abs(sngl(dos(i)))
        if (err.gt.eta) go to 20
 10   continue
c
C20   if (i.eq.nos) call seteru (28hinitds  eta may be too small, 28,
C    1  1, 2)
 20   continue
C     if (i.eq.nos) write(6,*) 'initds : eta may be too small'
      if (i.eq.nos) JGAMMA = 32
      initds = i
c
      return
      end

      subroutine d9gaml (xmin, xmax)
c june 1977 edition.   w. fullerton, c3, los alamos scientific lab.
c
c calculate the minimum and maximum legal bounds for x in gamma(x).
c xmin and xmax are not the only bounds, but they are the only non-
c trivial ones to calculate.
c
c             output arguments --
c xmin   dble prec minimum legal value of x in gamma(x).  any smaller
c        value of x might result in underflow.
c xmax   dble prec maximum legal value of x in gamma(x).  any larger
c        value of x might cause overflow.
c
C     double precision xmin, xmax, alnbig, alnsml, xln, xold, d1mach,
C    1  dlog
      double precision xmin, xmax

      double precision alnbig, alnsml, xln, xold
      integer i
C     external d1mach, dlog

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
C     alnsml = dlog(d1mach(1))
      alnsml =  log( FLTMIN  )
      xmin = -alnsml
      do 10 i=1,10
        xold = xmin
C       xln = dlog(xmin)
        xln =  log(xmin)
        xmin = xmin - xmin*((xmin+0.5d0)*xln - xmin - 0.2258d0 + alnsml)
     1    / (xmin*xln+0.5d0)
C       if (dabs(xmin-xold).lt.0.005d0) go to 20
        if ( abs(xmin-xold).lt.0.005d0) go to 20
 10   continue
C     call seteru (27hd9gaml  unable to find xmin, 27, 1, 2)
C     write(6,*) 'd9gaml : unable to find xmin'
      IGAMMA = 21
      return

c
 20   xmin = -xmin + 0.01d0
c
C     alnbig = dlog (d1mach(2))
      alnbig =  log ( FLTMAX  )
      xmax = alnbig
      do 30 i=1,10
        xold = xmax
C       xln = dlog(xmax)
        xln =  log(xmax)
        xmax = xmax - xmax*((xmax-0.5d0)*xln - xmax + 0.9189d0 - alnbig)
     1    / (xmax*xln-0.5d0)
C       if (dabs(xmax-xold).lt.0.005d0) go to 40
        if ( abs(xmax-xold).lt.0.005d0) go to 40
 30   continue
C     call seteru (27hd9gaml  unable to find xmax, 27, 2, 2)
C     write(6,*) 'd9gaml : unable to find xmax'
      IGAMMA = 22
      return
c
 40   xmax = xmax - 0.01d0
      xmin = dmax1 (xmin, -xmax+1.d0)
c
      return
      end

      double precision function d9lgmc (x)
c august 1977 edition.  w. fullerton, c3, los alamos scientific lab.
c
c compute the log gamma correction factor for x .ge. 10. so that
c dlog (dgamma(x)) = dlog(dsqrt(2*pi)) + (x-.5)*dlog(x) - x + d9lgmc(x)
c
C     double precision x, algmcs(15), xbig, xmax, dcsevl, d1mach,
C    1  dexp, dlog, dsqrt
      double precision x

      double precision algmcs(15), xbig, xmax, temp
      integer nalgm

      double precision dcsevl
      integer initds
C     external d1mach, dcsevl, dexp, dlog, dsqrt, initds
      external dcsevl, initds

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
c series for algm       on the interval  0.          to  1.00000e-02
c                                        with weighted error   1.28e-31
c                                         log weighted error  30.89
c                               significant figures required  29.81
c                                    decimal places required  31.48
c
      data algmcs(  1) / +.1666389480 4518632472 0572965082 2 d+0      /
      data algmcs(  2) / -.1384948176 0675638407 3298605913 5 d-4      /
      data algmcs(  3) / +.9810825646 9247294261 5717154748 7 d-8      /
      data algmcs(  4) / -.1809129475 5724941942 6330626671 9 d-10     /
      data algmcs(  5) / +.6221098041 8926052271 2601554341 6 d-13     /
      data algmcs(  6) / -.3399615005 4177219443 0333059966 6 d-15     /
      data algmcs(  7) / +.2683181998 4826987489 5753884666 6 d-17     /
      data algmcs(  8) / -.2868042435 3346432841 4462239999 9 d-19     /
      data algmcs(  9) / +.3962837061 0464348036 7930666666 6 d-21     /
      data algmcs( 10) / -.6831888753 9857668701 1199999999 9 d-23     /
      data algmcs( 11) / +.1429227355 9424981475 7333333333 3 d-24     /
      data algmcs( 12) / -.3547598158 1010705471 9999999999 9 d-26     /
      data algmcs( 13) / +.1025680058 0104709120 0000000000 0 d-27     /
      data algmcs( 14) / -.3401102254 3167487999 9999999999 9 d-29     /
      data algmcs( 15) / +.1276642195 6300629333 3333333333 3 d-30     /
c
      data nalgm, xbig, xmax / 0, 2*0.d0 /
c
      if (nalgm.ne.0) go to 10
C     nalgm = initds (algmcs, 15, sngl(d1mach(3)) )
      nalgm = initds (algmcs, 15, sngl(  EPSMIN ) )
C     xbig = 1.0d0/dsqrt(d1mach(3))
      xbig = 1.0d0/ sqrt(  EPSMIN )
C     xmax = dexp (dmin1(dlog(d1mach(2)/12.d0), -dlog(12.d0*d1mach(1))))
      xmax =  exp ( min ( log(FLTMAX   /12.d0), - log(12.d0*FLTMIN   )))
c
C10   if (x.lt.10.d0) call seteru (23hd9lgmc  x must be ge 10, 23, 1, 2)
c
 10   if (x.lt.10.d0) then
c       write(6,*) 'd9lgmc : x must be ge 10'
        IGAMMA = 51
C       d9lgmc = d1mach(2)
        d9lgmc = FLTMAX
        return
      end if

      if (x.ge.xmax) go to 20
c
      d9lgmc = 1.d0/(12.d0*x)
C     if (x.lt.xbig) d9lgmc = dcsevl (2.0d0*(10.d0/x)**2-1.d0, algmcs,
C    1  nalgm) / x

      if (x.lt.xbig) then
        temp   = dcsevl(2.0d0*(10.d0/x)**2-1.d0, algmcs, nalgm)
        if (IGAMMA .ne. 0) then
C         d9lgmc = d1mach(2)
          d9lgmc = FLTMAX
        else
          d9lgmc = temp / x
        end if
      end if
      return
c
 20   d9lgmc = 0.d0
C     call seteru (34hd9lgmc  x so big d9lgmc underflows, 34, 2, 0)
c     write(6,*) 'd9lgmc : x so big d9lgmc underflows'
      JGAMMA = 51
      return
c
      end

      double precision function dcsevl (x, a, n)
c
c evaluate the n-term chebyshev series a at x.  adapted from
c r. broucke, algorithm 446, c.a.c.m., 16, 254 (1973).
c
c             input arguments --
c x      dble prec value at which the series is to be evaluated.
c a      dble prec array of n terms of a chebyshev series.  in eval-
c        uating a, only half the first coef is summed.
c n      number of terms in array a.
c
      integer n
      double precision a(n), x
C     double precision d1mach
C     external         d1mach
      double precision twox, b0, b1, b2
      integer i, ni

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/

c
      b2 = 0.
C     if (n.lt.1) call seteru (28hdcsevl  number of terms le 0, 28, 2,2)
C     if (n.gt.1000) call seteru (31hdcsevl  number of terms gt 1000,
C    1  31, 3, 2)
C     if (x.lt.(-1.1d0) .or. x.gt.1.1d0) call seteru (
C    1  25hdcsevl  x outside (-1,+1), 25, 1, 1)
c
      if (n.lt.1) then
C       write(6,*) 'dcsevl : number of terms le 0'
        IGAMMA = 41
C       dcsevl = d1mach(2)
        dcsevl = FLTMAX
        return
      end if

      if (n.gt.1000) then
C       write(6,*) 'dcsevl : number of terms gt 1000'
        IGAMMA = 42
C       dcsevl = d1mach(2)
        dcsevl = FLTMAX
        return
      end if

      if (x.lt.(-1.1d0) .or. x.gt.1.1d0) then
C       write(6,*) 'dcsevl : x outside (-1,+1)'
        IGAMMA = 43
C       dcsevl = d1mach(2)
        dcsevl = FLTMAX
        return
      end if
c
      twox = 2.0d0*x
      b1 = 0.d0
      b0 = 0.d0
      do 10 i=1,n
        b2 = b1
        b1 = b0
        ni = n - i + 1
        b0 = twox*b1 - b2 + a(ni)
 10   continue
c
      dcsevl = 0.5d0 * (b0-b2)
c
      return
      end

      double precision function dlngam (x)
c     august 1980 edition.   w. fullerton, c3, los alamos scientific lab.
C     double precision x, dxrel, pi, sinpiy, sqpi2l, sq2pil,
C     1  y, xmax, dint, dgamma, d9lgmc, d1mach, dlog, dsin, dsqrt
      double precision x, dxrel, pi, sinpiy, sqpi2l, sq2pil,
     1     y, xmax, dgamma, d9lgmc
      double precision   temp
C     external d1mach, d9lgmc, dgamma, dint, dlog, dsin, dsqrt
      external d9lgmc, dgamma

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/
c
      data sq2pil / 0.9189385332 0467274178 0329736405 62 d0 /
c     sq2pil = alog (sqrt(2*pi)),  sqpi2l = alog(sqrt(pi/2))
      data sqpi2l / +.2257913526 4472743236 3097614947 441 d0 /
      data pi / 3.1415926535 8979323846 2643383279 50 d0 /
c
      data xmax, dxrel / 2*0.d0 /
c
      dlngam = 0d0
      if (xmax .eq. 0) then
C        xmax = d1mach(2)/dlog(d1mach(2))
         xmax =  FLTMAX  / log( FLTMAX  )
C        dxrel = dsqrt (d1mach(4))
         dxrel =  sqrt ( FLTMAX  )
       endif
C10   y = dabs (x)
 10   y =  abs (x)
      if (y.gt.10.d0) go to 20
c
c     dlog (dabs (dgamma(x)) ) for dabs(x) .le. 10.0
c
C     dlngam = dlog (dabs (dgamma(x)) )
      temp   = dgamma(x)
      if (IGAMMA .ne. 0) then
C     dlngam = d1mach(2)
         dlngam = FLTMAX
         return
      end if
      dlngam = log (abs (temp) )
      return
c
c     dlog ( dabs (dgamma(x)) ) for dabs(x) .gt. 10.0
c
C     20   if (y.gt.xmax) call seteru (
C     1  39hdlngam  dabs(x) so big dlngam overflows, 39, 2, 2)

 20   if (y.gt.xmax) then
c     write(6,*) 'dlngam : abs(x) so big dlngam overflows'
         IGAMMA = 61
C     dlngam = d1mach(2)
         dlngam = FLTMAX
         return
      end if
c
C     if (x.gt.0.d0) dlngam = sq2pil + (x-0.5d0)*dlog(x) - x + d9lgmc(y)

      temp = d9lgmc(y)
      if (IGAMMA .ne. 0) then
C     dlngam = d1mach(2)
         dlngam = FLTMAX
         return
      end if

      if (x.gt.0.d0) dlngam = sq2pil + (x-0.5d0)*log(x) - x + temp
      if (x.gt.0.d0) return
c
C     sinpiy = dabs (dsin(pi*y))
      sinpiy =  abs ( sin(pi*y))
C     if (sinpiy.eq.0.d0) call seteru (
C     1  31hdlngam  x is a negative integer, 31, 3, 2)

      if (sinpiy.eq.0.d0) then
c     write(6,*) 'dlngam : x is a negative integer'
         IGAMMA = 62
C     dlngam = d1mach(2)
         dlngam = FLTMAX
         return
      end if
c
C     dlngam = sqpi2l + (x-0.5d0)*dlog(y) - x - dlog(sinpiy) - d9lgmc(y)

      temp = d9lgmc(y)
      if (IGAMMA .ne. 0) then
C     dlngam = d1mach(2)
         dlngam = FLTMAX
         return
      end if

      dlngam = sqpi2l + (x-0.5d0)*log(y) - x - log(sinpiy) - temp
c
C     if (dabs((x-dint(x-0.5d0))*dlngam/x).lt.dxrel) call seteru (
C     1  68hdlngam  answer lt half precision because x too near negative
C     2integer, 68, 1, 1)
      if ( abs((x-dble(int(x-0.5d0)))*dlngam/x).lt.dxrel) JGAMMA = 61

      return
c
      end
      

      double precision function enorm(n,x)

      integer n
      double precision x(n)
c     **********
c
c     function enorm
c
c     given an n-vector x, this function calculates the
c     euclidean norm of x.
c
c     the euclidean norm is computed by accumulating the sum of
c     squares in three different sums. the sums of squares for the
c     small and large components are scaled so that no overflows
c     occur. non-destructive underflows are permitted. underflows
c     and overflows do not occur in the computation of the unscaled
c     sum of squares for the intermediate components.
c     the definitions of small, intermediate and large components
c     depend on two constants, rdwarf and rgiant. the main
c     restrictions on these constants are that rdwarf**2 not
c     underflow and rgiant**2 not overflow. the constants
c     given here are suitable for every known computer.
c
c     the function statement is
c
c       double precision function enorm(n,x)
c
c     where
c
c       n is a positive integer input variable.
c
c       x is an input array of length n.
c
c     subprograms called
c
c       fortran-supplied ... dabs,dsqrt
c
c     argonne national laboratory. minpack project. march 1980.
c     burton s. garbow, kenneth e. hillstrom, jorge j. more
c
c     **********
      integer i
      double precision agiant,floatn,one,rdwarf,rgiant,s1,s2,s3,xabs,
     *                 x1max,x3max,zero
      data one,zero,rdwarf,rgiant /1d0, 0d0, 3.834d-20, 1.304d19/

      enorm = -1d0
      s1 = zero
      s2 = zero
      s3 = zero
      x1max = zero
      x3max = zero
      floatn = n
      agiant = rgiant/floatn
      do 90 i = 1, n
         xabs = dabs(x(i))
         if (xabs .gt. rdwarf .and. xabs .lt. agiant) go to 70
            if (xabs .le. rdwarf) go to 30
c
c              sum for large components.
c
               if (xabs .le. x1max) go to 10
                  s1 = one + s1*(x1max/xabs)**2
                  x1max = xabs
                  go to 20
   10          continue
                  s1 = s1 + (xabs/x1max)**2
   20          continue
               go to 60
   30       continue
c
c              sum for small components.
c
               if (xabs .le. x3max) go to 40
                  s3 = one + s3*(x3max/xabs)**2
                  x3max = xabs
                  go to 50
   40          continue
                  if (xabs .ne. zero) s3 = s3 + (xabs/x3max)**2
   50          continue
   60       continue
            go to 80
   70    continue
c
c           sum for intermediate components.
c
            s2 = s2 + xabs**2
   80    continue
   90    continue
c
c     calculation of norm.
c
      if (s1 .eq. zero) go to 100
         enorm = x1max*dsqrt(s1+(s2/x1max)/x1max)
         go to 130
  100 continue
         if (s2 .eq. zero) go to 110
            if (s2 .ge. x3max)
     *         enorm = dsqrt(s2*(one+(x3max/s2)*(x3max*s3)))
            if (s2 .lt. x3max)
     *         enorm = dsqrt(x3max*((s2/x3max)+(x3max*s3)))
            go to 120
  110    continue
            enorm = x3max*dsqrt(s3)
  120    continue
  130 continue

      return
      end
c   function enorm

C ##############################################################################
C FRACDIFF-fdsim


      subroutine fdsim( n, ip, iq, ar, ma, d, rmu, y, s,
     *                  flmin, flmax, epmin, epmax)

      implicit none

c  generates a random time series for use with fracdf
c
c  Input :
c
c  n      integer  length of the time series
c  ip     integer  number of autoregressive parameters
c  ar     real    (ip) autoregressive parameters
c  ma     real    (iq) moving average parameters
c  d      real     fractional differencing parameters
c  rmu    real    (n) time series mean (mu + inmean + any external)
c  y      real    (n+iq) 1st n : normalized random numbers
c  s      real    (n+iq) workspace
c
c  Output :
c
c  s      real   (n) the generated time series

c-----------------------------------------------------------------------------
c
c        Simulates a series of length n from an ARIMA (p,d,q) model
c        with fractional d (0 < d < 0.5).
c
c-----------------------------------------------------------------------------

      integer            n, ip, iq
c     real               ar(ip), ma(iq), d
      double precision   ar(ip), ma(iq), d

      double precision   g0, vk, amk, sum, dk1, dk1d, dj, temp
c     real               y(n+iq), s(n+iq), rmu(n)
      double precision   y(*), s(*), rmu(n)

      double precision   flmin, flmax, epmin, epmax

      double precision   dgamr, dgamma

      external           dgamr, dgamma

      integer            k, j, i

      double precision   FLTMIN, FLTMAX, EPSMIN, EPSMAX
      common /MACHFD/    FLTMIN, FLTMAX, EPSMIN, EPSMAX
      save   /MACHFD/

      integer            IGAMMA, JGAMMA
      common /GAMMFD/    IGAMMA, JGAMMA
      save   /GAMMFD/

      double precision zero, one, two
      parameter        (zero = 0d0, one = 1d0, two = 2d0)

*--------------------------------------------------------------------------

        IGAMMA = 0
        JGAMMA = 0

        FLTMIN  = flmin
        FLTMAX  = flmax
        EPSMIN  = epmin
        EPSMAX  = epmax
c
c    Calculate g0

        temp = dgamr(one-d)
        if (IGAMMA .ne. 0) then
          do i = 1, n
            s(i) = zero
          end do
          return
        end if

        g0   = dgamma(one-two*d)*(temp*temp)
        if (IGAMMA .ne. 0) then
          do i = 1, n
            s(i) = zero
          end do
          return
        end if
c
c    Generate y(1)
c
        y(1) = y(1)*sqrt(g0)
c
c    Generate y(2) and initialise vk,phi(j)
c
        temp  = d / (one-d)
        vk    = g0*(one-(temp*temp))

        amk   = temp*y(1)
        s(1)  = temp
        y(2)  = amk + y(2)*sqrt(vk)
c
c    Generate y(3),...,y(n+iq)
c
        do k = 3, n + iq
          dk1  = real(k) - one
          dk1d = dk1 - d
c
c    Update the phi(j) using the recursion formula on W498
c
          do j = 1, k-2
            dj   = dk1 - real(j)
            s(j) = s(j)*(dk1*(dj-d)/(dk1d*dj))
          end do

          temp   = d / dk1d
          s(k-1) = temp
c
c    Update vk
c
        vk = vk * (one-(temp*temp))
c
c    Form amk
c
        amk = zero
        do j = 1, k-1
            amk = amk + s(j)*y(k-j)
        end do
c
c    Generate y(k)
c
        y(k) = amk + y(k)*sqrt(vk)

        end do
c
c    We now have an ARIMA (0,d,0) realisation of length n+iq in
c    y(k),k=1,n+iq. We now run this through an inverse ARMA(p,q)
c    filter to get the final output in x(k),k=1,n.
c
c I am not sure why there is - ar here (have changed it to + ar) - AG 07-09-2009
c since the inverse of (1-ar(L)) is (1 + ar(L)). A simple simulation-refit exercise 
c shows that this is so, otherwise we will get -1 * true(ar).

        do k = 1, n

        sum = zero

          do i = 1, ip
        	if (k .le. i) go to 10

        	sum = sum + ar(i)*s(k-i)
          end do

10        continue

          do j = 1, iq
        	sum = sum + ma(j)*y(k+iq-j)
          end do

        s(k) = sum + y(k+iq)

        end do

         do i = 1, n
           s(i) = s(i) + rmu(i)
         end do

       return
       end
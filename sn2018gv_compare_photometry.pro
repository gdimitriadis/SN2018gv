pro SN2018gv_compare_photometry

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'

  file_phot=!workspace+'SN2018gv/photometry/at2018gv_LC.txt'
  readcol,file_phot,phot_mjd,phot_filter,mag, mag_err,format='d,a,d,d',comment='#',/silent

  ind_b=where(phot_filter eq 'B')
  ind_v=where(phot_filter eq 'V')
  ind_g=where(phot_filter eq 'g')
  ind_r=where(phot_filter eq 'r')
  ind_i=where(phot_filter eq 'i')

  ;  plotnew='sn2018gv_lc_spec.eps'
  ;  SET_PLOT,"PS"
  ;  DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=30.0 , YSIZE=20.0

  cgplot,0,0,/nodata,yrange=[20.5,11],xrange=[58130,58160],ytitle='MAG',xtitle='MJD',$
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.08, 0.07, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5

  cgoplot,phot_mjd[ind_b],mag[ind_b],psym=16,color='blue'
  cgoplot,phot_mjd[ind_v],mag[ind_v]+1,psym=16,color='green'
  ;cgoplot,phot_mjd[ind_g],mag[ind_g],psym=16,color='dark green'
  ;cgoplot,phot_mjd[ind_r],mag[ind_r],psym=16,color='red'
  ;cgoplot,phot_mjd[ind_i],mag[ind_i],psym=16,color='orange'
  
  cgoplot,[58139,58139],[-30,20]
  
  ;;;; 11fe ;;;;
  
  sn2011fe_ebv_mw=0.007568
  
  file_phot_11fe=!workspace+'SN2018gv/photometry/comparisons/sn2011fe.out_B'
  phot_11fe_b=georgios_extract_photometry_out_files(file_phot_11fe,$
    /night_av,/no_weighted_mean,/cor_mw,ebv_mw=sn2011fe_ebv_mw,/ABMAGS)
  
  file_phot_11fe=!workspace+'SN2018gv/photometry/comparisons/sn2011fe.out_V'
  phot_11fe_v=georgios_extract_photometry_out_files(file_phot_11fe,$
    /night_av,/no_weighted_mean,/cor_mw,ebv_mw=sn2011fe_ebv_mw,/ABMAGS)
  
  ;cgoplot,phot_11fe_b.mjd+2334.5,phot_11fe_b.mag+3.15,psym=9,color='blue'
  cgoplot,phot_11fe_v.mjd+2334.5,phot_11fe_v.mag+4.05,psym=9,color='green'
  
  file_phot_11fe=!workspace+'SN2018gv/photometry/comparisons/zhang/sn2011fe.out_B'
  phot_11fe_b=georgios_extract_photometry_out_files(file_phot_11fe,$
    /night_av,/no_weighted_mean,/cor_mw,ebv_mw=sn2011fe_ebv_mw,/ABMAGS)
  
  cgoplot,phot_11fe_b.mjd+2334.5,phot_11fe_b.mag+3.05,psym=7,color='blue'
  
  cgoplot,[55804.840+2334.5,55804.840+2334.5],[-30,20]
  
  

end
pro SN2018gv_plot_photometry

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
  
  cgplot,0,0,/nodata,yrange=[17.5,11],xrange=[58130,58150],ytitle='MAG',xtitle='MJD',$
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.08, 0.07, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5
  
  cgoplot,phot_mjd[ind_b],mag[ind_b],psym=16,color='blue'
  cgoplot,phot_mjd[ind_v],mag[ind_v],psym=16,color='black'
  cgoplot,phot_mjd[ind_g],mag[ind_g],psym=16,color='green'
  cgoplot,phot_mjd[ind_r],mag[ind_r],psym=16,color='red'
  cgoplot,phot_mjd[ind_i],mag[ind_i],psym=16,color='orange'
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
  for i=0,n_elements(spec_mjd)-1 do begin
    cgoplot,[spec_mjd[i],spec_mjd[i]],[20,1],linestyle=2, thick=1
  endfor
  
  
  ;DEVICE,/CLOSE
  
end
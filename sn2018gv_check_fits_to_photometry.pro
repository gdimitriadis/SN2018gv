pro SN2018gv_check_fits_to_photometry


  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter

  set_plot, 'x'
  
  ind_filt_g=where(master_filter.shortid eq 'g_swope')
  ind_filt_r=where(master_filter.shortid eq 'r_swope')
  ind_filt_i=where(master_filter.shortid eq 'i_swope')

  mean_wave_g=master_filter[ind_filt_g].mean_wave
  mean_wave_r=master_filter[ind_filt_r].mean_wave
  mean_wave_i=master_filter[ind_filt_i].mean_wave

  sn18gv_z=0.0053d0
  sn18gv_ebv_mw=0.0497d0

  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,filters_for_mangling,truncate_percent,format='a,d,d,a,l,d',comment='#',/silent

  file_phot=!workspace+'SN2018gv/photometry/at2018gv_LC.txt'
  readcol,file_phot,phot_mjd,phot_filter,mag, mag_err,format='d,a,d,d',comment='#',/silent

  
  ind_b=where(phot_filter eq 'B')
  ind_v=where(phot_filter eq 'V')
  ind_g=where(phot_filter eq 'g')
  ind_r=where(phot_filter eq 'r')
  ind_i=where(phot_filter eq 'i')
  
  mag_b=mag[ind_b]
  phot_mjd_b=phot_mjd[ind_b]
  mag_v=mag[ind_v]
  phot_mjd_v=phot_mjd[ind_v]
  mag_g=mag[ind_g]
  phot_mjd_g=phot_mjd[ind_g]
  mag_r=mag[ind_r]
  phot_mjd_r=phot_mjd[ind_r]
  mag_i=mag[ind_i]
  phot_mjd_i=phot_mjd[ind_i]
  
  cgplot,0,0,/nodata,yrange=[19.5,10],xrange=[58132,58150],ytitle='MAG',xtitle='MJD',$
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.08, 0.07, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5
  
  cgoplot,phot_mjd[ind_b],mag[ind_b]-2,psym=16,color='blue'
  cgoplot,phot_mjd[ind_v],mag[ind_v]-1,psym=16,color='black'
  cgoplot,phot_mjd[ind_g],mag[ind_g],psym=16,color='green'
  cgoplot,phot_mjd[ind_r],mag[ind_r]+1,psym=16,color='red'
  cgoplot,phot_mjd[ind_i],mag[ind_i]+2,psym=16,color='orange'
  
  for i=1, n_elements(spec_name)-1 do begin

    mag_b_spline=SPLINE( phot_mjd_b[SORT(phot_mjd_b)], mag_b[SORT(phot_mjd_b)], spec_mjd[i], /DOUBLE )
    mag_v_spline=SPLINE( phot_mjd_v[SORT(phot_mjd_v)], mag_v[SORT(phot_mjd_v)], spec_mjd[i], /DOUBLE )
    mag_g_spline=SPLINE( phot_mjd_g[SORT(phot_mjd_g)], mag_g[SORT(phot_mjd_g)], spec_mjd[i], /DOUBLE )
    mag_r_spline=SPLINE( phot_mjd_r[SORT(phot_mjd_r)], mag_r[SORT(phot_mjd_r)], spec_mjd[i], /DOUBLE )
    mag_i_spline=SPLINE( phot_mjd_i[SORT(phot_mjd_i)], mag_i[SORT(phot_mjd_i)], spec_mjd[i], /DOUBLE )
    
    cgoplot,spec_mjd[i],mag_b_spline-2,psym=9,color='blue'
    cgoplot,spec_mjd[i],mag_v_spline-1,psym=9,color='black'
    cgoplot,spec_mjd[i],mag_g_spline,psym=9,color='green'
    cgoplot,spec_mjd[i],mag_r_spline+1,psym=9,color='red'
    cgoplot,spec_mjd[i],mag_i_spline+2,psym=9,color='orange'
    
  endfor
  
  
  ;cgoplot,[58139.354,58139.354],[-10,20]

end
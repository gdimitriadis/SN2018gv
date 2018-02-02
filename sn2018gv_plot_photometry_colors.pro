pro SN2018gv_plot_photometry_colors

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
  
  mag_b=mag[ind_b]
  mag_b_err=mag_err[ind_b]
  phot_mjd_b=phot_mjd[ind_b]
  mag_v=mag[ind_v]
  mag_v_err=mag_err[ind_v]
  phot_mjd_v=phot_mjd[ind_v]
  mag_g=mag[ind_g]
  mag_g_err=mag_err[ind_g]
  phot_mjd_g=phot_mjd[ind_g]
  mag_r=mag[ind_r]
  mag_r_err=mag_err[ind_r]
  phot_mjd_r=phot_mjd[ind_r]
  mag_i=mag[ind_i]
  mag_i_err=mag_err[ind_i]
  phot_mjd_i=phot_mjd[ind_i]
  
  cgplot,0,0, /nodata,xrange=[58130,58150],ytitle='B-V',xtitle='MJD',$
    yrange=[-0.5,1],CHARSIZE=1.2 ,CHARTHICK=3, position=[0.08, 0.07, 0.95, 0.98],$
    XThick = 5,YThick = 5  ,symsize=1.5
  
  for i=58135.0, 58147.0 do begin
    ind_b_f=where(phot_mjd_b ge i and phot_mjd_b lt i+1, count_b)
    ind_v_f=where(phot_mjd_v ge i and phot_mjd_v lt i+1, count_v)
    
    if count_b gt 1 and count_v gt 1 then begin
      mean_mjd=mean([phot_mjd_b[ind_b_f],phot_mjd_v[ind_v_f]])
      mean_b_w = sullivanweighted_mean( mag_b[ind_b_f], mag_b_err[ind_b_f],/correct )
      mean_v_w = sullivanweighted_mean( mag_v[ind_v_f], mag_v_err[ind_v_f],/correct )
      bv=mean_b_w[0]-mean_v_w[0]
      bv_err=sqrt(mean_b_w[1]^2+mean_v_w[1]^2)
    endif else begin
      mean_mjd=mean([phot_mjd_b[ind_b_f],phot_mjd_v[ind_v_f]])
      bv=mag_b[ind_b_f]-mag_v[ind_v_f]
      bv_err=sqrt(mag_b_err[ind_b_f]^2+mag_v_err[ind_v_f]^2)
    endelse
    
    cgoplot,mean_mjd,bv,psym=16
    oploterror,mean_mjd,bv,bv_err,psym=3
    
  endfor


end
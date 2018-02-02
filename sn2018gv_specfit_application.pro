pro SN2018gv_specfit_application

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter

  set_plot, 'x'

;  file='specinput_all.txt'
;  ;file='specinput_one.txt'
;
;  specfit,file,workingdir=!workspace+'SN2018gv/spectra/for_specfit/',/verbose,/refit ,niter=100  
;  


  restore,!workspace+'SN2018gv/spectra/for_specfit/results.sav'
  forprint,res.vsi6150, res.vsi6150err;,res.pewsi6150,res.pewsi6150err
  print,'---'
  ;forprint,res.vs5500,res.vs5500err

  file_specfit=!workspace+'SN2018gv/spectra/for_specfit/specinput_all.txt'
  readcol,file_specfit,sn_name,specfit_name,format='a,a',comment='#',/silent
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
  first_mjd=58134.0d0
  
;    plotnew='sn2018gv_velocities.eps'
;    SET_PLOT,"PS"
;    DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=30.0 , YSIZE=20.0
  
  cgplot,0,0,/nodata,xrange=[-1,15],yrange=[9,19],$
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.08, 0.07, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5,$
    ytitle='Vel (1d3 km/s)', xtitle='time (days)'
  
  for i=0,n_elements(specfit_name)-1 do begin
    ind_f=where(specfit_name[i] eq spec_name)
    ;print,spec_mjd[ind_f]
    
    IF(res[i].vsi6150 EQ !VALUES.F_NAN) THEN begin
      Print,'Not a number'
    endif else begin
      cgoplot,spec_mjd[ind_f]-first_mjd,res[i].vsi6150/1d3,psym=16, symsize=1.3, thick=3
      oploterror,spec_mjd[ind_f]-first_mjd,res[i].vsi6150/1d3,res[i].vsi6150err/1d3,psym=3, symsize=1.3
    endelse
    
    IF(res[i].vs5500 EQ !VALUES.F_NAN) THEN begin
      Print,'Not a number'
    endif else begin
      cgoplot,spec_mjd[ind_f]-first_mjd,res[i].vs5500/1d3,psym=4,color='red', symsize=1.3, thick=3
      oploterror,spec_mjd[ind_f]-first_mjd,res[i].vs5500/1d3,res[i].vs5500err/1d3,psym=3,color='red', symsize=1.3
    endelse
  
  endfor
  
  
;  cgplot,0,0,/nodata,xrange=[-1,10],yrange=[0,200]
;
;  for i=0,n_elements(specfit_name)-1 do begin
;    ind_f=where(specfit_name[i] eq spec_name)
;    ;print,spec_mjd[ind_f]
;
;    cgoplot,spec_mjd[ind_f]-first_mjd,res[i].pewsi6150,psym=16
;    oploterror,spec_mjd[ind_f]-first_mjd,res[i].pewsi6150,res[i].pewsi6150err,psym=3
;    
;    cgoplot,spec_mjd[ind_f]-first_mjd,res[i].pews5500,psym=16,color='red'
;    oploterror,spec_mjd[ind_f]-first_mjd,res[i].pews5500,res[i].pews5500err,psym=3
;    
;  endfor
  
  ;;; carbon ;;;
  
  mjd_carbon=[58134.144,58134.389,58134.506,58135.342,58135.530,58136.462,58138.420,58138.458,58139.354]
  vel_carbon=[15249.887,14571.633,14736.896,14760.974,14529.679,14459.688,13308.167,12809.046,12862.487]
  
  cgoplot,mjd_carbon-first_mjd,vel_carbon/1d3,psym=9,color='blue', symsize=1.3, thick=3


  ;DEVICE,/CLOSE

end
pro SN2018gv_plot_mangled_spectra_series_no_normalise

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'


  sn18gv_z=0.0053d0
  sn18gv_ebv_mw=0.0497d0
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent

;    plotnew='sn2018gv_spectra_warped_series_2.eps'
;    SET_PLOT,"PS"
;    DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=30.0 , YSIZE=15.0
  
  cgLoadCT, 74, NColors=n_elements(spec_name)-1

  
  cgplot,0,0,/nodata , xrange=[3000,10000] , yrange=[-1,1.5],  YTICKFORMAT="(A1)", XTICKFORMAT="(F10.0)" $
    , ytitle='LOG10 F$\sub'+cgGreek('lambda')+'$'+' + const.' , xtitle='Rest Wavelength ($\Angstrom$)' , $
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.04, 0.09, 0.96, 0.98],XThick = 5,YThick = 5  ,symsize=1.5, xticks=5, xminor=5

  for i=1,n_elements(spec_name)-1 do begin
    file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[i]
    readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

    wl_rest=wl/(1.+sn18gv_z)
    ccm_unred,wl_rest,flux,sn18gv_ebv_mw,flux_unred
    
    ;cgoplot, wl_rest, flux_unred
    ;cgoplot,[6500,6500],[0,1]

    ind_plot=where( flux_unred gt 0 )
    
    wl_rest_plot=wl_rest[ind_plot]
    flux_unred_plot=flux_unred[ind_plot]
    
    ;;;; smooth spectrum ;;;;
    res=MEDIAN(wl_rest_plot-SHIFT(wl_rest_plot,1))
    ; 20A running median for spectral cleaning
    win=ROUND(50./res)
    sg=SAVGOL(win,win,0,2)
    ;; smoothed spectrum - only used for plotting
    flux_unred_plot_smooth=CONVOL(flux_unred_plot,sg,/EDGE_TRUNCATE)
    
    ind_av=where(wl_rest_plot gt 6100 and wl_rest_plot lt 6110)
    
    foo1=mean(flux_unred_plot_smooth[ind_av])
    norm_f=1./foo1
    ;print,norm_f
    ;norm=flux_unred_plot_smooth/mean(flux_unred_plot_smooth[ind_av])
    
    fl_for_plot=norm_f*flux_unred_plot_smooth

    cgoplot,wl_rest_plot,alog10(fl_for_plot),color=i-1,thick=3

    
    
  endfor
  
  ;foo=long(spec_mjd)
  
  foo=spec_mjd-spec_mjd[0]
  
  cgColorbar,divisions=n_elements(spec_name)-1, NColors=n_elements(spec_name)-1,Range=[foo[1], foo[-1]],$
    TLocation='top', Position=[0.425, 0.86, 0.9, 0.90],CHARSIZE=0.8, title='Days since first spectrum'

  
  ;DEVICE,/CLOSE
  
;  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[1]
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw,flux_unred
;  ind_av=where(wl_rest gt 6500 and wl_rest lt 6550)
;
;  cgplot,wl_rest,alog10(flux_unred/mean(flux_unred[ind_av]))
  
end
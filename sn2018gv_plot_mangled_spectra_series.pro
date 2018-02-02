pro SN2018gv_plot_mangled_spectra_series

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'


  sn18gv_z=0.0053d0
  sn18gv_ebv_mw=0.0497d0
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent

;  plotnew='sn2018gv_spectra_warped_series.eps'
;  SET_PLOT,"PS"
;  DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=20.0 , YSIZE=30.0

  cgplot,0,0,/nodata , xrange=[2000,11000] , yrange=[-29.5,4.5],  YTICKFORMAT="(A1)", XTICKFORMAT="(F10.0)" $
    , ytitle='F$\sub'+cgGreek('lambda')+'$'+' + const.' , xtitle='Rest Wavelength ($\Angstrom$)' , $
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.06, 0.05, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5, xticks=5, xminor=5

  for i=1,n_elements(spec_name)-1 do begin

    CASE spec_source[i] OF
      'EFOSC2': color_plot='blue'
      'LRIS': color_plot='red'
      'LCO': color_plot='orange'
      'KAST': color_plot='black'
      'LCO_snex': color_plot='green'
      ELSE: PRINT, 'unknown source'
    ENDCASE


    file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[i]
    readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

    wl_rest=wl/(1.+sn18gv_z)
    ccm_unred,wl_rest,flux,sn18gv_ebv_mw,flux_unred

    ind_plot=where( flux_unred gt 0 and wl_rest gt 3300 and wl_rest lt 10000)

    cgoplot, wl_rest[ind_plot], flux_unred[ind_plot]/mean(flux_unred[ind_plot]) +2.5-2.4*i,$
      color=color_plot, thick=3


    if i eq 0 then begin
      foo=spec_mjd[0]
      foo_string=strtrim(string(foo,format='(F10.3)'),2)
    endif else begin
      foo=spec_mjd[i]-spec_mjd[0]
      ;print,foo*24.0d0
      foo_string='+'+strtrim(string(foo,format='(F10.3)'),2)
    endelse

    cgtext, 10100, 2.55-2.4*i , foo_string , color=color_plot , CHARSIZE=0.8 , CHARTHICK=3, /data
    cgtext, 2400, 4.55-2.4*i , spec_source[i] , color=color_plot , CHARSIZE=0.8 , CHARTHICK=3, /data

  endfor

  ;DEVICE,/CLOSE

end
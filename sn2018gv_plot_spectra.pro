pro SN2018gv_plot_spectra

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'
  
  
  sn18gv_z=0.0053d0
  sn18gv_ebv_mw=0.0497d0
  
;  file_spec_log='/Users/georgios_imac/SN_Data/SN2018gv/spectra/SN2018gv_spec_log.txt'
;  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass,format='a,d,d',comment='#',/silent
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
;  plotnew='sn2018gv_spectra_series.eps'
;  SET_PLOT,"PS"
;  DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=20.0 , YSIZE=30.0
  
  cgplot,0,0,/nodata , xrange=[2000,11000] , yrange=[-30.5,6.5],  YTICKFORMAT="(A1)", XTICKFORMAT="(F10.0)" $
    , ytitle='F$\sub'+cgGreek('lambda')+'$'+' + const.' , xtitle='Rest Wavelength ($\Angstrom$)' , $
    CHARSIZE=1.2 ,CHARTHICK=3, position=[0.06, 0.05, 0.95, 0.98],XThick = 5,YThick = 5  ,symsize=1.5, xticks=5, xminor=5
    
  for i=0,n_elements(spec_name)-1 do begin
    
    CASE spec_source[i] OF
      'EFOSC2': color_plot='blue'
      'LRIS': color_plot='red'
      'LCO': color_plot='orange'
      'KAST': color_plot='black'
      'LCO_snex': color_plot='green'
      ELSE: PRINT, 'unknown source'
    ENDCASE
    
        
    file_spec=!workspace+'SN2018gv/spectra/'+spec_name[i]
    readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
    
    wl_rest=wl/(1.+sn18gv_z)
    ccm_unred,wl_rest,flux,sn18gv_ebv_mw,flux_unred
    
    ind_plot=where( flux_unred gt 0 and wl_rest gt 3300 and wl_rest lt 10000)
    
;    CASE spec_name[i] OF
;      'SN2018gv_20180121_blue_kast.txt': ind_av=where( wl_rest gt 5500 and wl_rest lt 5600 )
;      ELSE: ind_av=where( wl_rest gt 6800 and wl_rest lt 6900 )
;    ENDCASE
;    
;    foo_av=mean(flux_unred[ind_av])
;    cgoplot, wl_rest[ind_plot], flux_unred[ind_plot]/foo_av +2.5-2.4*i , color=color_plot, thick=1

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
          
          
;          ind_trim=where(wl gt 3300 and wl lt 10000)
;          openw,lun,'t'+spec_name[i],/get_lun
;             for k=0, n_elements(wl[ind_trim])-1 do begin
;                printf,lun, wl[ind_trim[k]],flux[ind_trim[k]]
;             endfor
;          free_lun,lun

    
  endfor
  
;  file_spec=!workspace+'SN2018gv/spectra/SN2018gv_20180121_blue_kast.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;  cgplot,wl, flux , yrange=[0,2d-14], xrange=[3000,9000]
;  
;  file_spec=!workspace+'SN2018gv/spectra/SN2018gv_20180120_lco.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  cgoplot,wl, 0.15*flux,color='red'
;  
;  file_spec=!workspace+'SN2018gv/spectra/SN2018gv_20180121_red_kast.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;  cgoplot,wl, flux,color='blue'

  
;  ;file_spec=!workspace+'SN2018gv_stuff/spectra/other_files/SN2018gv_test.txt'
;  file_spec=!workspace+'SN2018gv_stuff/spectra/SN2018gv_test.txt'
;
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  ;cgplot,wl, flux*1d-20, yrange=[1d-16,1d-15]
;      openw,lun,'SN2018gv_20180120_lco.txt',/get_lun
;         for k=0, n_elements(wl)-1 do begin
;            printf,lun, wl[k],flux[k]*1d-20
;         endfor
;      free_lun,lun
  
 ;DEVICE,/CLOSE
  
end
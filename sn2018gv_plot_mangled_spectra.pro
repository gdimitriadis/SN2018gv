pro SN2018gv_plot_mangled_spectra

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter

  set_plot, 'x'

  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[8]
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
  
  cgplot,wl, flux,color='grey', xrange=[3000,10000]
  
  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[9]
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

  cgoplot,wl, 0.8*flux,color='red'
  
  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/m'+spec_name[10]
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

  cgoplot,wl, flux,color='blue'
  
end
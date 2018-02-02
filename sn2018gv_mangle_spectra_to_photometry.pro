pro SN2018gv_mangle_spectra_to_photometry

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter

  set_plot, 'x'
  vega_struct = read_vega()
 
  ind_filt_b=where(master_filter.shortid eq 'B_swope')
  ind_filt_v=where(master_filter.shortid eq 'V_swope_LC9844')
  ind_filt_g=where(master_filter.shortid eq 'g_swope')
  ind_filt_r=where(master_filter.shortid eq 'r_swope')
  ind_filt_i=where(master_filter.shortid eq 'i_swope')

  mean_wave_b=master_filter[ind_filt_b].mean_wave
  mean_wave_v=master_filter[ind_filt_v].mean_wave
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

  
  for i=1, n_elements(spec_name)-1 do begin
    
    mag_b_spline=SPLINE( phot_mjd_b[SORT(phot_mjd_b)], mag_b[SORT(phot_mjd_b)], spec_mjd[i], /DOUBLE ) - master_filter[ind_filt_b].ab_offset
    mag_v_spline=SPLINE( phot_mjd_v[SORT(phot_mjd_v)], mag_v[SORT(phot_mjd_v)], spec_mjd[i], /DOUBLE ) - master_filter[ind_filt_v].ab_offset
    mag_g_spline=SPLINE( phot_mjd_g[SORT(phot_mjd_g)], mag_g[SORT(phot_mjd_g)], spec_mjd[i], /DOUBLE ) - master_filter[ind_filt_g].ab_offset
    mag_r_spline=SPLINE( phot_mjd_r[SORT(phot_mjd_r)], mag_r[SORT(phot_mjd_r)], spec_mjd[i], /DOUBLE ) - master_filter[ind_filt_r].ab_offset
    mag_i_spline=SPLINE( phot_mjd_i[SORT(phot_mjd_i)], mag_i[SORT(phot_mjd_i)], spec_mjd[i], /DOUBLE ) - master_filter[ind_filt_i].ab_offset
    
    flux_b=flux_to_apparent_mag(mag_b_spline,IFILTER=ind_filt_b ,/VEGASYS, /reverse)     ;  erg/s/cm^2/A
    flux_v=flux_to_apparent_mag(mag_v_spline,IFILTER=ind_filt_v ,/VEGASYS, /reverse)     ;  erg/s/cm^2/A
    flux_g=flux_to_apparent_mag(mag_g_spline,IFILTER=ind_filt_g ,/VEGASYS, /reverse)     ;  erg/s/cm^2/A
    flux_r=flux_to_apparent_mag(mag_r_spline,IFILTER=ind_filt_r ,/VEGASYS, /reverse)     ;  erg/s/cm^2/A
    flux_i=flux_to_apparent_mag(mag_i_spline,IFILTER=ind_filt_i ,/VEGASYS, /reverse)     ;  erg/s/cm^2/A
        
    file_spec=!workspace+'SN2018gv/spectra/trimmed_spectra/t'+spec_name[i]
    readcol,file_spec, wl, fl ,format='d,d',comment='#',/silent
    
    print,'spec is ',spec_name[i]
    
    if spec_name[i] eq 'SN2018gv_20180124_b_kast.txt' then begin
      fl=fl*1d-15
    endif
    
;      plotnew='m'+spec_name[i]+'.eps'
;      SET_PLOT,"PS"
;      DEVICE,/ENCAPSULATED,LANDSCAPE=0,FILENAME=plotnew,/color , XSIZE=30.0 , YSIZE=20.0    
    
    CASE filters_for_mangling[i] OF
      1:Begin
        
        print,'using g,r,i'

        ;; flux from spectra
        g_spec_integ=filter_integ(ind_filt_g,wl,fl,0.0d0)/master_filter[ind_filt_g].area_lambda
        r_spec_integ=filter_integ(ind_filt_r,wl,fl,0.0d0)/master_filter[ind_filt_r].area_lambda
        i_spec_integ=filter_integ(ind_filt_i,wl,fl,0.0d0)/master_filter[ind_filt_i].area_lambda

        ;; response functions
        extract_filter,ind_filt_g,wave_g,response_g
        extract_filter,ind_filt_r,wave_r,response_r
        extract_filter,ind_filt_i,wave_i,response_i
                
        if truncate_percent[i] eq 0 then begin
          print,'no truncating'
          mang = mangle_spectrum2( wl, fl, [ind_filt_g,ind_filt_r,ind_filt_i],$
            [flux_g,flux_r,flux_i] ,$
            [vega_struct] ,/usemeanwave,manglefactor=mangle_factor)
        endif else begin
          print,'truncating to ',truncate_percent[i],' %'
          mang = mangle_spectrum2( wl, fl, [ind_filt_g,ind_filt_r,ind_filt_i],$
            [flux_g,flux_r,flux_i] ,$
            [vega_struct] ,/usemeanwave,/truncate_filters,truncate_pc=truncate_percent[i],manglefactor=mangle_factor )
        endelse
        
        yrange_plot=max([fl,mang])

        cgplot, wl, fl, xrange=[3500,10000],yrange=[0,1.05*yrange_plot] $
          , position=[0.09, 0.09, 0.93, 0.95],ytitle='Flux (erg s$\up-1$ cm$\up-2$ $\Angstrom$$\up-1$)',$
          xtitle='Wavelength ($\Angstrom$)',CHARSIZE=1.2 ,CHARTHICK=3,$
          XThick = 5,YThick = 5  ,symsize=1.5,YSTYLE=9
        
        ymaxspec=!Y.CRANGE[1]*0.9
        ymaxfilt=MAX(response_g)
        tempfg=response_g*(ymaxspec/ymaxfilt)
        tempfr=response_r*(ymaxspec/ymaxfilt)
        tempfi=response_i*(ymaxspec/ymaxfilt)
        
        cgoplot, [wave_g],[tempfg], color='dark green'
        cgoplot, [wave_r],[tempfr], color='red'
        cgoplot, [wave_i],[tempfi], color='orange'
            
        cgoplot,wl,mang, color='grey'

        cgoplot, mean_wave_g,flux_g, psym=16, color='dark green',SYMSIZE=1
        cgoplot, mean_wave_r,flux_r, psym=16, color='red',SYMSIZE=1
        cgoplot, mean_wave_i,flux_i, psym=16, color='orange',SYMSIZE=1

        cgoplot,mean_wave_g,g_spec_integ, psym=9, color='dark green',SYMSIZE=1.5
        cgoplot,mean_wave_r,r_spec_integ, psym=9, color='red',SYMSIZE=1.5
        cgoplot,mean_wave_i,i_spec_integ, psym=9, color='orange',SYMSIZE=1.5
        
        ymin=min(mangle_factor)
        ymax=max(mangle_factor)
        
        AXIS,YAXIS=1,/save,YRANGE=[ymin-0.1,ymax+0.1],YSTYLE=1,$
          YTITLE='Relative mangling function',XThick = 5,YThick = 5,$
          CHARSIZE=1.2 ,CHARTHICK=3

        cgoplot,wl,mangle_factor,color='magenta',THICK=2
        
        final_spectrum=mang
        
        End
        
        2:Begin

          print,'using g,i'

          ;; flux from spectra
          g_spec_integ=filter_integ(ind_filt_g,wl,fl,0.0d0)/master_filter[ind_filt_g].area_lambda
          i_spec_integ=filter_integ(ind_filt_i,wl,fl,0.0d0)/master_filter[ind_filt_i].area_lambda

          ;; response functions
          extract_filter,ind_filt_g,wave_g,response_g
          extract_filter,ind_filt_i,wave_i,response_i
          
 
          if truncate_percent[i] eq 0 then begin
            print,'no truncating'
            mang = mangle_spectrum2( wl, fl, [ind_filt_g,ind_filt_i],$
              [flux_g,flux_i] ,$
              [vega_struct] ,/usemeanwave,manglefactor=mangle_factor )
          endif else begin
            print,'truncating to ',truncate_percent[i],' %'
            mang = mangle_spectrum2( wl, fl, [ind_filt_g,ind_filt_i],$
              [flux_g,flux_i] ,$
              [vega_struct] ,/usemeanwave,/truncate_filters,truncate_pc=truncate_percent[i],manglefactor=mangle_factor )
          endelse
          
          yrange_plot=max([fl,mang])
          
          cgplot, wl, fl, xrange=[3500,10000],yrange=[0,3.*yrange_plot] $
            , position=[0.09, 0.09, 0.93, 0.95],ytitle='F (Flux (erg s$\up-1$ cm$\up-2$ $\Angstrom$$\up-1$)',$
            xtitle='Wavelength ($\Angstrom$)',CHARSIZE=1.2 ,CHARTHICK=3,$
            XThick = 5,YThick = 5  ,symsize=1.5,YSTYLE=9

          ymaxspec=!Y.CRANGE[1]*0.9
          ymaxfilt=MAX(response_g)
          tempfg=response_g*(ymaxspec/ymaxfilt)
          tempfi=response_i*(ymaxspec/ymaxfilt)
        
          cgoplot, [wave_g],[tempfg], color='dark green'
          cgoplot, [wave_i],[tempfi], color='orange'
        
          cgoplot,wl,mang, color='grey'

          cgoplot, mean_wave_g,flux_g, psym=16, color='dark green',SYMSIZE=1
          cgoplot, mean_wave_i,flux_i, psym=16, color='orange',SYMSIZE=1

          cgoplot,mean_wave_g,g_spec_integ, psym=9, color='dark green',SYMSIZE=1.5
          cgoplot,mean_wave_i,i_spec_integ, psym=9, color='orange',SYMSIZE=1.5
          
          ymin=min(mangle_factor)
          ymax=max(mangle_factor)
        
          AXIS,YAXIS=1,/save,YRANGE=[ymin-0.1,ymax+0.1],YSTYLE=1,$
            YTITLE='Relative mangling function',XThick = 5,YThick = 5,$
            CHARSIZE=1.2 ,CHARTHICK=3
          
          cgoplot,wl,mangle_factor,color='magenta',THICK=2
          
          final_spectrum=mang

        End
 
        ELSE: PRINT, 'Problem!!!'
    ENDCASE
    
    ;DEVICE,/CLOSE
; stop   
;    openw,lun,'m'+spec_name[i],/get_lun
;        for k=0, n_elements(wl)-1 do begin
;            printf,lun, wl[k],final_spectrum[k]
;        endfor
;    free_lun,lun
    
        
  endfor


end
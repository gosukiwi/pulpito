app.factory 'FileWriter', ['Fs', 'Mkdirp', (fs, mkdirp) ->
  writeFile = (file, buffer, handleError) ->
    mkdirp file.dirname, (err, res) ->
      return handleError(err) if err && err.code != 'EEXIST'
      fs.writeFile file.fullpath, buffer, 0, buffer.length, (err) ->
        handleError(err) if err

  (files, buffer, err) ->
    if Array.isArray(files)
      err = buffer
      writeFile(f.file, f.buffer, err) for f in files
    else
      writeFile(files, buffer, err)
]

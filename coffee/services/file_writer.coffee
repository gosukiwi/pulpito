app.factory 'FileWriter', ['Fs', (fs) ->
  writeFile = (file, buffer, handleError) ->
    fs.mkdir file.dirname, '0777', (err, res) ->
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

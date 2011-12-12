class FileTypes < EnumerateIt::Base
  associate_values(
          :export => 0,
          :import => 1,
          :information => 2
  )
end

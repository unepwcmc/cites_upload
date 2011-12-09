class CompilationBasis < EnumerateIt::Base
  associate_values(
          :trade => [0, "Actual Trade"],
          :permits => [1, "Permits Issued"]
  )
end


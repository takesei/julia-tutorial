module Fixpoint

export fixpoint_validation, fixpoint_render

using Plots

    function fixpoint_validation(f, x)
      if f(x)!=x; error("x is not a fixpoint"); end
      v = ForwardDiff.derivative(f, x)
      return v>1 ? "source" : "sink"
    end

    function _render(p, fp)
      plot!([p, p], [fp, fp], label=fixpoint_validation(f, p), marker=:circle)
    end

    function fixpoint_plot(f, domein, fixpoints)
      plot(f, Domein)
      for p in fixpoints
        _render(p, f(p))
      end
      plot!()
end
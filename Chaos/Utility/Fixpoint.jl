module Fixpoint

export fixpoint_validation, fixpoint_render

using Plots
gr()

  function fixpoint_validation(f, x)
    if f(x) != x; error("x is not a fixpoint"); end
    v = ForwardDiff.derivative(f, x)
    return v>1?"source":"sink"
  end

  function _render(f, p)
    return p, f(p), fixpoint_validation(f, p)
  end

  function fixpoint_render(f, domein, fixpoints)
    x = []
    y = []
    l = []

    plot(f, Domein)

    for p in fixpoints
      _x, _y, _l = _render(f, p)
      push!(x, [_x])
      push!(y, [_y])
      push!(l, _l)
    end

    plot!(x, y, label=l, marker=:circle)
  end
end

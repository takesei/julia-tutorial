module Cobweb

export cobweb, cobweb_plot

using Plots
gr()

  _rendering(x, f) = [[x,x],[x,f(x)]], [[x,f(x)],[f(x),f(x)]], f(x)
  _initial_rendering(x, f) = [[x,x],[x,f(x)]], [[0,f(x)],[f(x),f(x)]], f(x)

  function cobweb(f, x_0, N=100)
    x, y, v = _initial_rendering(x_0, f)
    for i=2:N
      _x, _y, v = _rendering(v, f)
      append!(x, _x)
      append!(y, _y)
    end
    return [x, y]
  end

  function cobweb_plot(f, domein, x_0, N=100)
    range = [f(i)for i in domein]
    diagonal = copy(domein)
    plot(domein, [range, diagonal], label="", lw=2)
    x, y = [], []

    for _x_0 in x_0
      _x, _y = cobweb(f, _x_0, N)
      append!(x, _x)
      append!(y, _y)
    end

    if maximum(range) < maximum(diagonal)
      plot!(x, y, label="", color="green", xlims=[minimum(domein), maximum(domein)], ylim=[minimum(diagonal), maximum(diagonal)])
    else
      plot!(x, y, label="", color="green", xlims=[minimum(domein), maximum(domein)], ylim=[minimum(range), maximum(range)])
    end
  end
end

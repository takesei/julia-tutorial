module Cobweb

using Plots

export cobweb_plot

    function _rendering(x, fx)
      plot!([x,x], [x,fx], label="", color="green")
      plot!([x,fx], [fx,fx], label="", color="green")
    end

    function _init_rendering(x, fx)
      plot!([x,x], [0,fx], label="", color="green")
      plot!([x,fx], [fx,fx], label="", color="green")
    end


    function _cobweb(f, x_0, N)
      rv = []
      for i in x_0
        orb = zeros(N+1)
        orb[1] = i
        for i=1:N
          orb[i+1] = f(orb[i])
        end

        _init_rendering(orb[1], orb[2])
        for i=2:N
          _rendering(orb[i], orb[i+1])
        end

        push!(rv, orb)
      end
      rv
    end


    function cobweb_plot(f, domein, x_0, N=100)

      range = [f(i)for i in domein]
      diagonal = copy(domein)
      plot(domein, [range, diagonal], label="", lw=2)

      x_l = [minimum(domein), maximum(domein)]
      y_l = maximum(range)<maximum(diagonal) ? [minimum(diagonal), maximum(diagonal)] : [minimum(range), maximum(range)]

      rv = _cobweb(f, x_0, N)
      plot!(xlim=x_l, ylim=y_l)
      rv
    end
end
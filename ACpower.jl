### A Pluto.jl notebook ###
# v0.20.19

#> [frontmatter]
#> chapter = 0
#> section = 1
#> order = 1
#> image = "https://github.com/Ricardo-Luis/me-2/blob/6252e9ac22fae09aa08ac7cde09225d40c80fd23/images/card/ACpower.png?raw=true"
#> title = "Gráficos interativos"
#> layout = "layout.jlhtml"
#> tags = ["preliminaries"]
#> date = "2024-09-09"
#> description = "Notebook introdutório de revisão de conceitos potência em circuitos CA e construção de gráficos em Julia com Pluto.jl."
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ b411a974-d7fa-49d6-a1b7-ab32eb8bbe78
using PlutoUI, PlutoTeachingTools, Plots, NumericalIntegration
#=
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - NumericalIntegration.jl, tool for numerically integrating presampled data
=#

# ╔═╡ 4726fac7-ee43-4e91-b95e-dbb1a09e1b7d
TwoColumnWideLeft(md"`ACpower.jl`", md"`Last update: 09·09·2024`")

# ╔═╡ 65b1d051-b0ec-4b7b-a7e7-c3a5c3ac1a0a
md"""
---
$$\begin{gather}
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Potência em sistemas de corrente alternada}}} \\
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Análise com gráficos interativos}}}
\end{gather}$$
---
"""

# ╔═╡ 9cd8d54b-23ae-4586-90c5-f560ff418f73
md"""
# Âmbito

Este *notebook* apresenta dois objetivos a serem concretizados em simultâneo:

- serve de revisão a conceitos sobre **potência** em circuitos de corrente alternada (CA);
- e para introduzir a construção de gráficos na linguagem de computação científica `Julia` usando a interface de trabalho `Pluto.jl`.

Sendo um documento computacional de revisão de conceitos de base em engenharia eletrotécnica, mas fundamentais na aprendizagem e aplicação de máquinas elétricas, o estudante poderá dividir a sua atenção nos dois objetivos propostos.
"""

# ╔═╡ dc578ed3-d498-4c02-9b7c-2f121e4358c6


# ╔═╡ aab928f1-2ecb-46ee-8ce9-ca146c5aad1b
md"""
# Problema 

\
Suponha uma fonte de tensão CA ideal monofásica com $U=100\rm{V}$ e frequência, $f=50\rm{Hz}$.  

Esta fonte de tensão alimenta uma carga linear variável, cujo o valor de corrente poderá atingir $100\rm A$ e o seu desfasamento relativamente à tensão variar entre: $-\frac{\pi}{2}\leqslant\varphi\leqslant+\frac{\pi}{2} \:\:(\rm{rad})$.

**Desafio:**
 > **Criar um ambiente de análise das potências temporais envolvidas e das potências ativa, reativa e aparente deste circuito CA.**
"""

# ╔═╡ 165d6a97-67fc-4bbe-936b-47b33f9e0e33
aside((md"""
!!! tip "Observações" 
	O texto descritivo é realizado no formato [**Markdown**](https://www.markdownguide.org/) cuja sintaxe é muito fácil de aprender e usar:\
	[📺 Learn Markdown in 1 minute](https://www.youtube.com/shorts/-aSSrmAXHDg).
	
	Para iniciar um texto descritivo no formato Makdown numa célula vazia utilizar as teclas de atalho: `Ctrl` + `m`
	\
	\
	A notação matemática é realizada no formato ``\LaTeX`` para a apresentação de variáveis e equações:\
	[📺 Math equations and expressions - LaTeX in 100 seconds](https://www.youtube.com/watch?v=V4htbZeDUMU)\
	Trata-se de um sistema de composição tipográfica de qualidade, que inclui recursos destinados à produção de documentos técnico-científicos.

	Para equações mais complexas existem ferramentas disponíveis _online_ que facilitam a obtenção do código $\LaTeX$. Exemplo: [Equation Editor for online mathematics](https://editor.codecogs.com/)

	Para escrever no formato $\LaTeX$ utilizar o símbolo `$` (sinal de dólar) no ínício e fim da equação/expressão ou em alternativa o duplo sinal de acento grave, ``,  também designado por _backticks_.

"""), v_offset=-750)

# ╔═╡ 37a9799f-a746-4754-b3f2-692665bb9abd
md"""
# Forma computacional do problema

## Tensão alternada

"""

# ╔═╡ 9e0ea587-0459-47ab-aa35-dcb458d158df
md"""
Definem-se as grandezas que vão permitir caracterizar a onda temporal da tensão alternada:
"""

# ╔═╡ b263485a-636d-4a57-9c4e-dd10bf217826
# AC voltage, V; frequency, Hz; initial voltage phase angle, rad:
U, f, θᵤ = 100.0, 50, 0.0 

# ╔═╡ e628a95a-30a5-4c58-8645-f01ac434b0d3
md"""
Cálculo da frequência angular elétrica, $\omega$ :
"""

# ╔═╡ cdfa6084-a6e6-4205-9a25-8fbe6ef8fb53
ω = 2π*f

# ╔═╡ 90f50ad3-c86d-4e65-a338-c0fb082b1ef8
md"""
Definição do intervalo de tempo de análise, por exemplo, 2 períodos de onda alternada:
"""

# ╔═╡ 215762b7-272b-4749-83c9-532fed7671ef
t=0:1e-5:0.04  					   # time range
#t=range(0, 0.04, length=10000)    # another Julia code option    

# ╔═╡ 96b48340-ec08-4d87-b1f1-46b18a12b038
md"""
A determinação da tensão temporal do circuito CA vem dado por:

$\tag{1}
u(t)=\sqrt2\:U\sin(\omega\:t+\theta_u) \quad\quad \rm{com}\it\quad t \in \left [\:0;\: k\:T\: \right ]$
"""

# ╔═╡ 8794c335-e5a7-4b91-b6e4-30e31eff27e9
Foldable("Onde:",md"
 -  $U$, valor eficaz da tensão, V
 -  $k$, número inteiro de períodos de onda
 -  $\theta_u$, o ângulo inicial da tensão, rad
 -  $T$, período da onda CA, $\:T=f^{-1}$ , em segundos")

# ╔═╡ 9a3db49a-5fa0-48ac-9de7-5cad998674c6
md"""
Computacionalmente, obtêm-se os valores de $u(t)$:
"""

# ╔═╡ 2416a6df-b494-4620-a4cb-53efc61ae202
u = √2*U*sin.(ω*t .+ θᵤ) 

# ╔═╡ f0dad876-ded8-4da1-8b4e-243dde05b386
aside((md"""
!!! tip "Observações"
	A linguagem Julia aceita caracteres gregos e/ou símbolos como variáveis. A lista de possibilidades vem definida em [Unicode Input](https://docs.julialang.org/en/v1/manual/unicode-input/); Exemplos: 
      - para a raíz quadrada, escrever: `\sqrt` + premir tecla `TAB`
      - para a letra grega ω, escrever: `\omega` + tecla `TAB`
      - θᵤ é obtido fazendo: `\theta` + `TAB` + `\_u` + `TAB`

	Isto permite que as equações para cálculo computacional fiquem muito semelhantes à sua escrita matemática!
	\
	\
	Na equação: \

	`u = √2*U*sin.(ω*t .+ θᵤ)`, antes dos operadores matemáticos e após a função `sin` aparece um ponto final `.`: 	
	isso é o símbolo de [*broadcasting*](https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting) e evita ter de  definir uma instrução de ciclo `for`, de modo a obter a tensão instantânea `u` para todos os valores de `t`, simplificando a escrita de código.
	\
	\
	Os comentários dentro de uma linha de código são iniciados com o sinal de cardinal, `#`, sendo o texto à sua direita ignorado pelo compilador Julia. \
	Para um comentário de várias linhas o texto é delimitado por `#=` no início do comentário e `=#` no final do comentário. 
"""), v_offset=-680)

# ╔═╡ 87bcbe0c-19e7-4c07-a1d7-bb1a83da434b
md"""
## Corrente alternada
Uma vez que a carga é variável define-se a corrente, $I$ e o ângulo de desfasamento da corrente em relação à tensão, $\varphi$, com base em dois controlos deslizantes (*sliders*) que permitem uma análise interativa. 
"""

# ╔═╡ 6eea4290-cf1c-45d8-b1f8-54e7a36b72e2


# ╔═╡ dc524dd6-01fe-45fc-bf89-49f07cd88c7e
md"""
### 💻 Controlos da corrente

 $$I [A] =$$ $(@bind I Slider(0:0.1:100; default=60, show_value=true)) $$\quad\quad ; \quad\quad$$ $$\phi[\degree]$$ $(@bind ϕ Slider(-90:0.1:90; default=-30, show_value=true))  
"""

# ╔═╡ ac602069-394d-4d58-825e-853dae565122
aside((md"""
!!! tip "Observações"
	Cada célula de cálculo de um _notebook_ Pluto aceita apenas uma instrução Julia. 

	No, entanto por vezes, surge a necessidade de organizar parte dos cálculos num único bloco. Nessas situações, para agrupar várias expressões de cálculo numa única célula, utilizam-se as instruções `begin`...`end` ou `let`...`end`: 
	
	- na opção `begin`...`end`, as variáveis utilizadas ou definidas são globais (para todo o _notebook_);
	- na opção  `let`...`end`, as variáveis utilizadas ou definidas são locais (só existem nessa célula do _notebook_).

	Em, qualquer dos casos, o resultado exibido é sempre relativo à última instrução (penúltima linha do bloco).

"""), v_offset=50)

# ╔═╡ 03e2bb91-acd2-4a71-b31a-2935bfecba08
begin
	φ = ϕ * π/180 	# degrees to radians conversion 
	φ = round(φ, digits=4)
	#φ = deg2rad()  # option: Julia function to convert degrees to radians 
	I, φ 			# the values assigned to (I, φ) change as the sliders are moved!
end

# ╔═╡ db25a19e-2329-42ab-8602-bcc0749385fd
md"""
A determinação da corrente temporal do circuito AC vem dado por:

$\tag{2}
i(t)=\sqrt2\:I\sin(\omega\:t+\theta_i) \quad\quad \rm{com}\it\quad t \in \left [\:0;\: k\:T\: \right ]$

Em $(2)$, $I$ e $\theta_i$ são o valor eficaz e o ângulo inicial, da corrente elétrica, respectivamente.  
"""

# ╔═╡ 62075218-1518-4706-8433-87910e4e543a
md"""
Computacionalmente, calculam-se os valores de $i(t)$:
"""

# ╔═╡ 3446025f-e81a-450f-a5c2-517eee3e6e54
begin
	θᵢ = θᵤ + φ      
	i= √2*I*sin.(ω*t .+ θᵢ)	
end

# ╔═╡ 72acfb93-b5bb-4767-8214-2571165304bd
aside((md"""
!!! tip "Observações"
	- Na margem esquerda de cada célula do *notebook* pode optar por **mostrar** ou **ocultar** o código que origina o resultado visualizado, premindo o símbolo 👁;
	- A partir da margem esquerda do *notebook* pode arrastar qualquer célula para qualquer outra posição vertical do *notebook*.

	👆 Assim, arraste a célula relativa aos controlos deslizantes do valor eficaz e desfasamento da corrente, para junto de um dos gráficos abaixo e visualize-os de uma forma interativa!
"""), v_offset=210)

# ╔═╡ 01e4e485-c4ba-473c-9de3-d28179e147e2
md"""
## Gráfico: $u(t)$, $i(t)$, $p(t)$
"""

# ╔═╡ 8d7ad9b1-2233-4a3f-ad60-8c759aea65e7
md"""
Mostrar potência intantânea, $p(t)$? $(@bind z Select([0 => "Não", 1 => "Sim",]))
"""

# ╔═╡ 4892078c-73aa-4eb6-851a-714a08ee050c


# ╔═╡ ee73db77-137d-456e-970e-957dbb99a60d
md"""
# Potências num circuito CA (carga linear)
"""

# ╔═╡ fa0fb15d-45e4-48bf-82bf-8352c677c35b
md"""
A potência instantânea, $p(t)$, vem dado pelo produto da tensão e corrente instantâneas:

$\tag{3}
p(t)=u(t)\:i(t)$

Computacionalmente, fica:
"""

# ╔═╡ 19bb2956-2c05-47c6-bb25-29343e82e73a
p = u.*i 			

# ╔═╡ ad4c33ec-473c-4b72-86ca-d2674d45813b
begin
	# Select the select box above the plot, to see the instantaneous power, p(t), together with voltage and current plot, with a secondary axis:
	if z == 0
		plot(t, u, xlabel="t (s)", label="u(t)", minorticks=5)
		plot!(t,i, ylabel="u, i  (V, A)", label="i(t)", 
			  	   legend=:bottomleft, size=(602,402))
	else
		plot(t, u, xlabel="t (s)", label="u(t)", minorticks=5)
		plot!(t,i, ylabel="u, i  (V, A)", label="i(t)", legend=:bottomleft)
		plot!(twinx(), t, p/1000, ylabel="p (kVA)", label="p(t)", lc=:green, 
								  lw=2, ylims=[-15,20], legend=:bottomright,
			 					  size=(650,400))
	end
end

# ╔═╡ d3426bad-31ba-4123-bea7-54032004d03d
md"""
A potência instantânea pode ser decomposta em 2 componentes.\
Substituindo $(1)$ e $(2)$ em $(3)$, tém-se:

$\begin{align}
p(t) &= 2\:U\:I\sin(\omega\:t+\theta_u)\:\sin(\omega\:t+\theta_i) \\
\\
\because\quad \varphi &= \theta_i - \theta_u  \quad\&\quad\theta_u=0\quad\therefore\\
\\
p(t) &= 2\:U\:I\sin(\omega\:t)\:\sin(\omega\:t+\varphi) \\
\\
\because\quad \sin(x)\: \sin(y) &= \frac{1}{2}\left [ \cos(x-y)-\cos(x+y) \right ] \quad\therefore\\
\\
\tag{4}
p(t) &= U \: I \: \cos\varphi - U \: I \: \cos(2\:\omega\:t + \varphi)\\
\end{align}$
"""

# ╔═╡ 7494ef14-aa3e-4d34-ad06-f39ccb7c6a0f
md"""
Atendendo à expressão da potência aparente, $S=U\:I$, a potência instantânea, $p(t)$, pode ser reescrita na forma, $(5)$:

$\tag{5}
p(t) = S \: \cos\varphi - S \: \cos(2\:\omega\:t + \varphi)$
"""

# ╔═╡ c1ba8a60-1211-46a0-abe8-43d9563300c2
md"""
De $(4)$, verifica-se a a potência instantânea, $p(t)$, depende um termo constante e de um termo alternado com o dobro de frequência angular das grandezas elétricas, $u(t)$ e $i(t)$.

O termo constante tem a designação de **potência ativa**, $P$, enquanto a segunda parcela tem a designação de potência alternada, $p_{alt}(t)$, representadas em $(6)$ e $(7)$, respectivamente.

$\begin{align}
\tag{6}
P &= U \: I \: \cos \varphi\\
\\
\tag{7}
p_{alt}(t) &= U \: I \: \cos(2\:\omega\:t + \varphi)\\
\end{align}$
"""

# ╔═╡ 940b3c87-7edd-43ae-b53c-fb0bcd40c9ed
begin
	P = U*I*cos(φ)				# active power, W
	P = P/1000 					# active power, kW
	P = round(P, digits=1)      # round P value to one decimal place, kW
end

# ╔═╡ 3cce2987-e158-4c53-b07b-5943adc1808a
pₐₗₜ = U*I*cos.(2ω*t .+ φ)	 

# ╔═╡ c3686c4c-e88d-4820-b9a1-44232d6039c9


# ╔═╡ 3ccfdb1c-7167-4a3b-95db-34a896613d53
md"""
## Gráfico: $p(t)$, $p_{alt}(t)$; $P$, $S$
"""

# ╔═╡ 329339cd-9013-47b9-818b-fb9a0cfc4ffd
md"""
Do gráfico anterior é possível verificar:
 - a potência ativa, $P$, corresponde ao valor médio da potência instantânea, $p(t)$; 
 - a potência aparente, $S$, corresponde à amplitude da potência alternada, $p_{alt}(t)$.
"""

# ╔═╡ ae4d2175-1274-40a4-b290-5fb4bd647899
md"""
Das expressões $(4)$ ou $(5)$ e da representação temporal de $p(t)$, verifica-se que a **potência ativa**, $P$, corresponde ao valor médio, num determinado período, da potência elétrica instantânea, ou seja, pode ser representada por:

$\tag{8}
P=\frac{1}{T}\int_0^T {p(t)} \:\rm{d}t$

Computacionalmente pode-se verificar por integração numérica dos valores de $p(t)$:
"""

# ╔═╡ 307d39f1-fde6-4cf7-b165-97cb789788ba
begin
	Pa=integrate(t, p)/0.04 		# Active power by numerical integration, W
	Pa=round(Pa/1000, digits=1) 	# W->kW and round to one decimal place, kW
end

# ╔═╡ db989dcb-1f4b-4773-b258-3fc7036c5878


# ╔═╡ 37aedeb7-9a81-4ae0-bad9-1e58ae356b5f
md"""
A parcela relativa à potência alternada, $p_{alt}$, pode ainda ser analisada do seguinte modo:

Aplicando em $(7)$, a seguinte a identidade trigonométrica:

$$\because \quad\cos(x+y)=\cos x \cos y - \sin x \sin y\quad\therefore$$

Obtém-se, $(9)$:

$\tag{9}
p_{alt} = \underbrace{U\:I\: \cos\varphi}_{P}\:\cos(2\:\omega\:t) - \underbrace{U\:I \sin\varphi}_{Q}\:\sin(2\:\omega\:t)$

Em $(9)$, $Q$ representa potência reativa, que se traduz pela amplitude do fluxo de potência que varia alternadamente entre a fonte de alimentação e a carga linear, $(10)$:

$\tag{10}
Q = U\:I\:\sin\varphi$

Substituindo $(9)$, $(6)$ e $(10)$ em $(4)$, obtém-se a potência instantânea, $p(t)$, dada por $(11)$:

$\tag{11}
p(t) = \underbrace{P\:[1-\cos(2\:\omega\:t)]}_{p_1(t)} + \underbrace{Q\:\sin(2\:\omega\:t)}_{p_2(t)}$
"""

# ╔═╡ f562f00a-8779-44ec-8209-b2b23618c3a5
begin
	Q = U*I*sin(φ)
	S = U*I
	Q, S = round.((Q/1000, S/1000), digits=1)
end;

# ╔═╡ 11579602-0e0a-4800-a615-c0b13441ebf8
begin
	# p(t):
	plot(t, p/1000, title="p(t) = P - pₐₗₜ(t)", 
				legend=:topright, xlabel="t  (s)", ylims=[-11,21], lw=2, 
				lc=:green, ylabel="kVA, kW", label="p(t)", minorticks=5, 
		 		size=(700,400))
	
	# pₐₗₜ(t):
	plot!(t, pₐₗₜ/1000, lc=:purple, label="pₐₗₜ(t)")
	plot!([S], seriestype=:hline, ls=:dot, lc=:purple, label=:none)
	plot!([-S], seriestype=:hline, ls=:dot, lc=:purple, label=:none)
	plot!([(0.024,0), (0.024, -S)], arrow = arrow(:closed, 0.1, :both), 
								   color = :purple, label=:none)
	annotate!([0.025], [-S/2], ["S"], :purple)

	
	# P:
	plot!([P], seriestype=:hline, ls=:dot, lw=2, lc=:orange, label="P")
	plot!([0], seriestype=:hline, lc=:black, label=:none)
	plot!([(0.006,0), (0.006, P)], arrow = arrow(:closed, 0.1, :both), 
								   color = :orange, label=:none)
	annotate!([0.007], [P/2], ["P"], :orange)
	
	# S:
	plot!([P+S], seriestype=:hline, ls=:dot, lc=:green, label=:none)
	plot!([(0.018,P), (0.018, P+S)], arrow = arrow(:closed, 0.1, :both), 
								   color = :green; label=:none)
	annotate!([0.019], [3(P+S)/4], ["S"], :green)
end

# ╔═╡ 8596cac1-5f79-49a8-abbb-1283d15831f0
md"""
Assim, computacionalmente obtêm-se os valores das potências ativa, reativa e aparente:\
 $$P=$$ $P $$\rm kW\:;\:\:Q=$$ $Q $$\rm kVAr\:;\:\:S=$$ $S $$\rm kVA$$
"""

# ╔═╡ ee7e6566-9e18-4b64-acba-f21d7b2799bf
md"""
De $(11)$, calculam-se computacionamente as parcelas das potências oscilantes, $p_1(t)$ e $p_2(t)$, que se relacionam com as potências ativa e reativa, respectivamente: 
"""

# ╔═╡ 4c5a7341-c210-40c0-b8e4-810f2a15245b
p₁ = P*(1 .- cos.(2ω*t));

# ╔═╡ 8ee8c903-7b59-4ca9-8a20-be8edcab7e09
p₂ = Q*sin.(2ω*t);

# ╔═╡ 1b66f615-427e-4d95-9058-0e31b239b006
aside((md"""
!!! tip "Observações"
	Ao colocar `;` no final das células de cálculo, os respetivos resultados dessas células não são exibidos, mas continuam a ser calculados.

	Desta forma, evita-se a apresentação de resultados intercalares ou em bruto.

	Os resultados também podem ser inseridos no texto descritivo, através da instrução `$()`, colocando nos parênteses o nome da variável que cujo o(s) valor(es) se deseja(m) apresentar. Assim, os resultados apresentados no texto descritivo mantêm-se atualizados com a utilização interativa do _notebook_.
"""), v_offset=-330)

# ╔═╡ 19688a6a-fbca-4eaf-8acd-25a604902c04
md"""
## Gráfico: $p(t)$, $p_1(t)$, $p_2(t)$; $P$, $Q$, $S$
"""

# ╔═╡ b91708f8-e434-4007-b33b-6ee4a35e082b
begin
	# p(t), p₁(t), p₂(t):
	plot(t, p/1000, title="p(t)=p₁(t)+p₂(t) ;  P=$(P)kW ;  Q=$(Q)kVAr ; S=$(S)kVA", 
				legend=:topright, xlabel="t  (s)", lw=2, lc=:green, ylims=[-11,21],
				ylabel="kW, kVAr, kVA",	label="p(t)", minorticks=5, size=(700,400))
	plot!(t, p₁, lc=:red, label="p₁(t)") 
	plot!(t, p₂, lc=:blue, label="p₂(t)")
	
	# Q:
	plot!([Q], seriestype=:hline, ls=:dot, lc=:blue, label=:none)
	plot!([-Q], seriestype=:hline, ls=:dot, lc=:blue, label=:none)
	plot!([(0.015,0), (0.015, -abs(Q))], arrow = arrow(:closed, 0.1, :both), 
										 color = :blue; label=:none)
	annotate!([0.014], [-abs(Q)/2], ["Q"], :blue)
	
	# P:
	plot!([P], seriestype=:hline, ls=:dot, lw=2, lc=:orange, label="P")
	plot!([0], seriestype=:hline, ls=:dot, lc=:red, label=:none)
	plot!([2P], seriestype=:hline, ls=:dot, lc=:red, label=:none)
	plot!([(0.01,0), (0.01, 2*P)], arrow = arrow(:closed, 0.1, :both), 
								   color = :red, label=:none)
	annotate!([0.0088], [4P/3], ["2P"], :red)
	
	# S:
	plot!([P+S], seriestype=:hline, ls=:dot, lc=:green, label=:none)
	plot!([(0.02,P), (0.02, P+S)], arrow = arrow(:closed, 0.1, :both), 
								   color = :green; label=:none)
	annotate!([0.019], [3(P+S)/4], ["S"], :green, label=:topleft)
end

# ╔═╡ 0d3f746a-4fc4-4e3f-883a-9e62e965be80
md"""
Do gráfico anterior é possível verificar:
 - a potência ativa, $P$, corresponde a metade do valor de pico a pico da potência oscilante $p_1(t)$;
 - a potência reativa, $Q$, corresponde à amplitude da potência da potência oscilante $p_2(t)$.
"""

# ╔═╡ 8ed9575a-eab7-4160-a9d8-719ad09b3f4e
begin
	#=
	Advanced CSS code for text formatting in Pluto.jl notebooks
	- Applies text justification and automatic hyphenation to content
	- Bilingual support: European Portuguese (pt-PT) and English (en)
	- Dynamic mapping based on the 'lang' selector variable
	- Uses system fonts with fallbacks for better compatibility
	- Significantly improves readability of long texts
	
	Developed with GenAI assistance from Claude (Anthropic) - September 2025
	=#
	
	# Language code mapping for specific locales
	#lang_code = lang == "pt" ? "pt-PT" : lang
	lang_code = "pt-PT"
	
	html"""<div lang="$(lang_code)">
	<style>
	pluto-output p {
	   text-align: justify;
	   hyphens: auto;
	   -webkit-hyphens: auto;
	   -ms-hyphens: auto;
	   -moz-hyphens: auto;
	}
	pluto-output {
	   font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
	   font-size: 100%;
	}
	</style>
	</div>
	"""
end

# ╔═╡ 84b38e0e-a51f-4ee0-b238-c224e4dd8c94
md"""
# *Notebook*
"""

# ╔═╡ b926a0d3-2447-48bc-9fff-7a838d4c047e
md"""
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Plots](http://docs.juliaplots.org/latest/), [NumericalIntegration](https://github.com/dextorious/NumericalIntegration.jl).
"""

# ╔═╡ aa8b45e1-b6d5-4ee4-8043-1c5b3decef13
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ 9b1afa94-4b72-4958-b17d-e28b5845c517
TableOfContents(title="Índice")

# ╔═╡ 7ee6b760-3345-4e69-b24b-1729f5fb56e9
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, o tópico assinalado com "💻" requer a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 4b501cf6-5fbf-48be-8004-b67dd81d6276
md"""
|  |  |
|:--:|:--|
|  | This notebook, [ACpower.jl](https://ricardo-luis.github.io/me-2/ACpower.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
NumericalIntegration = "e7bfaba1-d571-5449-8927-abc22e82249b"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
NumericalIntegration = "~0.3.4"
Plots = "~1.41.1"
PlutoTeachingTools = "~0.4.4"
PlutoUI = "~0.7.71"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.1"
manifest_format = "2.0"
project_hash = "21174c2f7672402bb58a573af61f0fc167dbc322"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "f7817e2e585aa6d924fd714df1e2a84be7896c60"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.3.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e4c6a16e77171a5f5e25e9646617ab1c276c5607"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.26.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "76b3b7c3925d943edf158ddb7f693ba54eb297a5"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7bb1361afdb33c7f2b085aa49ea8fe1b0fb14e58"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.1+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "50c11ffab2a3d50192a228c313f05b5b5dc5acb2"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "f2905febca224eade352a573e129ef43aa593354"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.16.1"

    [deps.Interpolations.extensions]
    InterpolationsForwardDiffExt = "ForwardDiff"
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4255f0032eafd6451d707a51d5f0248b8a165e4d"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.3+0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.11.1+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "706dfd3c0dd56ca090e86884db6eda70fa7dd4af"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d3c8af829abaeba27181db4acb485b18d15d89c6"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3cce3511ca2c6f87b19c34ffc623417ed2798cbd"
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.10+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.NumericalIntegration]]
deps = ["Interpolations", "LinearAlgebra", "Logging"]
git-tree-sha1 = "9c6c03622c410853ac378cf17f71016d23a823a7"
uuid = "e7bfaba1-d571-5449-8927-abc22e82249b"
version = "0.3.4"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.44.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1f7f9bbd5f7a2e5a9f7d96e51c9754454ea7f60b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "12ce661880f8e309569074a61d3767e5756a199f"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.1"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "d0f6e09433d14161a24607268d89be104e743523"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.4"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "eb38d376097f47316fe089fc62cb7c6d85383a52"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "e1d5e16d0f65762396f9ca4644a5f4ddab8d452b"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.12.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "b8693004b385c842357406e3af647701fe783f98"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.15"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.5.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╟─4726fac7-ee43-4e91-b95e-dbb1a09e1b7d
# ╟─65b1d051-b0ec-4b7b-a7e7-c3a5c3ac1a0a
# ╟─9cd8d54b-23ae-4586-90c5-f560ff418f73
# ╟─dc578ed3-d498-4c02-9b7c-2f121e4358c6
# ╟─aab928f1-2ecb-46ee-8ce9-ca146c5aad1b
# ╟─165d6a97-67fc-4bbe-936b-47b33f9e0e33
# ╟─37a9799f-a746-4754-b3f2-692665bb9abd
# ╟─9e0ea587-0459-47ab-aa35-dcb458d158df
# ╠═b263485a-636d-4a57-9c4e-dd10bf217826
# ╟─e628a95a-30a5-4c58-8645-f01ac434b0d3
# ╠═cdfa6084-a6e6-4205-9a25-8fbe6ef8fb53
# ╟─90f50ad3-c86d-4e65-a338-c0fb082b1ef8
# ╠═215762b7-272b-4749-83c9-532fed7671ef
# ╟─96b48340-ec08-4d87-b1f1-46b18a12b038
# ╟─8794c335-e5a7-4b91-b6e4-30e31eff27e9
# ╟─9a3db49a-5fa0-48ac-9de7-5cad998674c6
# ╠═2416a6df-b494-4620-a4cb-53efc61ae202
# ╟─f0dad876-ded8-4da1-8b4e-243dde05b386
# ╟─87bcbe0c-19e7-4c07-a1d7-bb1a83da434b
# ╟─6eea4290-cf1c-45d8-b1f8-54e7a36b72e2
# ╟─dc524dd6-01fe-45fc-bf89-49f07cd88c7e
# ╟─ac602069-394d-4d58-825e-853dae565122
# ╠═03e2bb91-acd2-4a71-b31a-2935bfecba08
# ╟─db25a19e-2329-42ab-8602-bcc0749385fd
# ╟─62075218-1518-4706-8433-87910e4e543a
# ╠═3446025f-e81a-450f-a5c2-517eee3e6e54
# ╟─72acfb93-b5bb-4767-8214-2571165304bd
# ╟─01e4e485-c4ba-473c-9de3-d28179e147e2
# ╟─8d7ad9b1-2233-4a3f-ad60-8c759aea65e7
# ╠═ad4c33ec-473c-4b72-86ca-d2674d45813b
# ╟─4892078c-73aa-4eb6-851a-714a08ee050c
# ╟─ee73db77-137d-456e-970e-957dbb99a60d
# ╟─fa0fb15d-45e4-48bf-82bf-8352c677c35b
# ╠═19bb2956-2c05-47c6-bb25-29343e82e73a
# ╟─d3426bad-31ba-4123-bea7-54032004d03d
# ╟─7494ef14-aa3e-4d34-ad06-f39ccb7c6a0f
# ╟─c1ba8a60-1211-46a0-abe8-43d9563300c2
# ╠═940b3c87-7edd-43ae-b53c-fb0bcd40c9ed
# ╠═3cce2987-e158-4c53-b07b-5943adc1808a
# ╟─c3686c4c-e88d-4820-b9a1-44232d6039c9
# ╟─3ccfdb1c-7167-4a3b-95db-34a896613d53
# ╟─11579602-0e0a-4800-a615-c0b13441ebf8
# ╟─329339cd-9013-47b9-818b-fb9a0cfc4ffd
# ╟─ae4d2175-1274-40a4-b290-5fb4bd647899
# ╠═307d39f1-fde6-4cf7-b165-97cb789788ba
# ╟─db989dcb-1f4b-4773-b258-3fc7036c5878
# ╟─37aedeb7-9a81-4ae0-bad9-1e58ae356b5f
# ╟─8596cac1-5f79-49a8-abbb-1283d15831f0
# ╠═f562f00a-8779-44ec-8209-b2b23618c3a5
# ╟─ee7e6566-9e18-4b64-acba-f21d7b2799bf
# ╠═4c5a7341-c210-40c0-b8e4-810f2a15245b
# ╠═8ee8c903-7b59-4ca9-8a20-be8edcab7e09
# ╟─1b66f615-427e-4d95-9058-0e31b239b006
# ╟─19688a6a-fbca-4eaf-8acd-25a604902c04
# ╟─b91708f8-e434-4007-b33b-6ee4a35e082b
# ╟─0d3f746a-4fc4-4e3f-883a-9e62e965be80
# ╟─8ed9575a-eab7-4160-a9d8-719ad09b3f4e
# ╟─84b38e0e-a51f-4ee0-b238-c224e4dd8c94
# ╟─b926a0d3-2447-48bc-9fff-7a838d4c047e
# ╠═b411a974-d7fa-49d6-a1b7-ab32eb8bbe78
# ╟─aa8b45e1-b6d5-4ee4-8043-1c5b3decef13
# ╠═9b1afa94-4b72-4958-b17d-e28b5845c517
# ╟─7ee6b760-3345-4e69-b24b-1729f5fb56e9
# ╟─4b501cf6-5fbf-48be-8004-b67dd81d6276
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

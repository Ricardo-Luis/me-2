### A Pluto.jl notebook ###
# v0.20.15

#> [frontmatter]
#> image = "https://github.com/Ricardo-Luis/me-2/blob/d4c738671f520db3ebc89b69cfef0cb4e3aec8c8/images/card/ME-II.png?raw=true"
#> title = "Máquinas Elétricas II"
#> date = "2025-09-01"
#> description = "Apresentação da unidade curricular: competências, programa, funcionamento e avaliação."
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

# ╔═╡ d3541bae-bcdb-4e58-89ce-3ad5204e5e56
Columns(md"""
		`ME-II.jl`""", md"""
		`Language:` $(@bind lang Select([
		"pt" => "Português",
		"en" => "English",
		]))""", md"""
		`Last update: 01·09·2025`""")

# ╔═╡ 399c7a6d-88da-4966-a524-9a00491809a1
if lang == "pt"
	md"# Apresentação da Unidade Curricular"
elseif lang == "en"
	md"# Course Presentation"
end

# ╔═╡ 117c889a-2c0a-4648-befb-4067cb0869a1
if lang == "pt"
	md"""
$\colorbox{Bittersweet}{\textcolor{white}{\Large\texttt{Máquinas Elétricas II (ME II)}}}$
	"""
elseif lang == "en"
	md"""
$\colorbox{Bittersweet}{\textcolor{white}{\Large\texttt{Electric Machinery II (EM II)}}}$
	"""
end

# ╔═╡ 20e8ef2a-b923-4e9d-86c8-53aafcd2d8e3
if lang == "pt"
	md"""
	### Sumário:
	- Competências
	- Programa
	- Funcionamento
	- Avaliação"""
elseif lang == "en"
		md"""
	### Summary:
	- Competencies
	- Syllabus
	- Course Organization
	- Assessment"""
end

# ╔═╡ 797e2cea-ff51-43b2-8d5b-29c6740ec9c5
if lang == "pt"
	md" # Competências a Desenvolver"
elseif lang == "en"
	md" # Competencies to Develop"
end

# ╔═╡ 4a679083-ab50-414c-b0e7-1c1ca50f53a0
if lang == "pt"
	md"""
	- **Reconhecer máquinas elétricas (ME), síncronas e de corrente contínua (CC), identificando as suas características construtivas e funcionais distintivas;**

	
	- **Resolver problemas práticos usando curvas características das ME, considerando diferentes condições de operação;**

	
	- **Distinguir processos de regulação na operação de ME, diferenciando a aplicação de princípios fundamentais e consequências práticas;**

	
	- **Selecionar procedimentos de operação de ME associadas em sistemas de acionamento e de energia, coordenando e regulando grandezas elétricas e mecânicas de forma fundamentada;**

	
	- **Explicar o funcionamento de ME não convencionais, explorando aplicações, vantagens e limitações em contextos específicos;**

	
	- **Distinguir os regimes transitórios das ME, examinando o comportamento e resultados experimentais em ensaios específicos;**

	
	- **Aplicar e analisar técnicas de instalação, operação, supervisão e manutenção de ME, executando procedimentos em ME isoladas e integradas em sistemas elétricos e industriais.**
	"""
elseif lang == "en"
		md"""
	- **Recognize electrical machines (EM), synchronous and direct current (DC), identifying their distinctive constructive and functional characteristics;**

	
	- **Solve practical problems using characteristic curves of EM, considering different operating conditions;**

	
	- **Distinguish regulation processes in the operation of EM, differentiating the application of fundamental principles and practical consequences;**

	
	- **Select operating procedures of EM associated in drive and energy systems, coordinating and regulating electrical and mechanical quantities in a well-founded manner;**

	
	- **Explain the operation of non-conventional EM, exploring applications, advantages and limitations in specific contexts;**

	
	- **Distinguish the transient phenomena in EM, examining the behaviour and experimental results in specific tests;**

	
	- **Apply and analyse techniques for installation, operation, supervision and maintenance of EM, executing procedures in stand-alone EM as well integrated in electrical and industrial systems.**	
	"""
end

# ╔═╡ 6dd8ad18-9069-4500-bc84-51e502d57c37
md"""
![](https://upload.wikimedia.org/wikipedia/commons/6/6a/Bloom%27s_revised_taxonomy.svg)
"""

# ╔═╡ 596dca72-e55b-4559-862b-0807defad8a2
if lang == "pt"
	md"**Fig. 1 - Domínios das competências**, [^Tidema]."
elseif lang == "en"
	md"**Fig. 1 - Competency domains**, [^Tidema]."
end

# ╔═╡ 689fbf6c-8504-4648-a1da-cf5049fa5310
if lang == "pt"
	md"# Enquadramento Pedagógico"
elseif lang == "en"
	md"# Pedagogical Framework"
end

# ╔═╡ dce5565f-b004-489d-827b-b0af02c3cc6b
if lang == "pt"
	md"""
	Aproximar os estudantes do mundo técnico das máquinas elétricas através da prática e resolução de problemas reais.
	"""
elseif lang == "en"
	md"""
	Connecting students with the technical world of electrical machines through practice and real problem solving.
	"""
end

# ╔═╡ 7cda7c65-c1e5-4038-8414-406b30da4675
if lang == "pt"
	md"## Metodologias"
elseif lang == "en"
	md"## Methodologies"
end

# ╔═╡ 250883b0-68da-46e8-8159-d478587e7c31
if lang == "pt"
	Foldable("Aprendizagem Baseada em Problemas", md"Resolução de exercícios individuais e em grupo, integrando conceitos fundamentais com aplicações práticas. A metodologia promove discussão, análise crítica e pensamento analítico, envolvendo os estudantes na aplicação progressiva da teoria a situações reais.")
elseif lang == "en"
	Foldable("Problem-Based Learning", md"Individual and group problem solving, integrating fundamental concepts with practical applications. The methodology promotes discussion, critical analysis and analytical thinking, engaging students in the progressive application of theory to real situations.")
end

# ╔═╡ f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
if lang == "pt"
	Foldable("Experimentação Colaborativa e Prática Reflexiva", 
			 md"""
			 As aulas Práticas direcionam os alunos para o trabalho em equipa na realização de ensaios experimentais, de modo a:
			 - desenvolver as competências técnicas nos procedimentos de ensaio e de segurança;
			 - promover a reflexão estruturada sobre as observações e os resultados obtidos;
			 - através do processo iterativo de experimentação e reflexão coletiva:
			   - aprofundar a compreensão teórica dos conceitos em estudo;
			   - desenvolver aptidões práticas;
			   - estimular o pensamento crítico.""")
elseif lang == "en"
	Foldable("Collaborative Experimentation and Reflective Practice", 
			 md"""
			 Practical classes direct students to teamwork in conducting experimental tests, in order to:
			 - develop technical competencies in testing and safety procedures;
			 - promote structured reflection on observations and results obtained;
			 - through the iterative process of experimentation and collective reflection:
			   - deepen theoretical understanding of concepts under study;
			   - develop practical skills;
			   - stimulate critical thinking.""")
end

# ╔═╡ 364d1e59-c671-41ba-9be9-83aa1e167208
begin
	Julia_logo="https://github.com/JuliaLang/julia/raw/master/doc/src/assets/logo.svg"
	Pluto_logo="https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg"

	if lang == "pt"
		Foldable("Integração de Tecnologias de Educação Aberta", md"""
|     |    |
|-----|:--:|
| [Linguagem de computação científica](https://julialang.org/): | $(Resource(Julia_logo, :height => 35)) |
|     |    |
| [*Notebooks* reativos](https://plutojl.org/): | $(Resource(Pluto_logo, :height => 35)) |
|     |    |

\

#### Educação aberta:

![](https://www.ub.uzh.ch/dam/jcr:0417c862-6463-465e-8f3c-b4fc585cb6e0/FAIR-data-principles.png)

**Fig. 2 - Aplicação dos princípios FAIR, [^Bezjak_2018]**
""")
	elseif lang == "en"
		Foldable("Integration of Open Education Technologies", md"""
	|     |    |
	|-----|:--:|
	| [Scientific computing language](https://julialang.org/): | $(Resource(Julia_logo, :height => 35)) |
	|     |    |
	| [Reactive notebooks](https://plutojl.org/): | $(Resource(Pluto_logo, :height => 35)) |
	|     |    |
				 
	\
				 
	#### Open education:
				 
	![](https://www.ub.uzh.ch/dam/jcr:0417c862-6463-465e-8f3c-b4fc585cb6e0/FAIR-data-principles.png)
	**Fig. 2 - Application of FAIR principles, [^Bezjak_2018]**
	""")
	end
end

# ╔═╡ d6816245-7d61-4136-91f0-e8c480665278
if lang == "pt"
	md"# Programa"
elseif lang == "en"
	md"# Syllabus"
end

# ╔═╡ 689dad68-fd9d-4e6b-8adc-029ca1f08ccc
if lang == "pt"
	Foldable("Máquina de Corrente Contínua (CC)", md"
- Constituição, princípio funcionamento, tipos excitação, esquemas equivalentes
- Potência, perdas e rendimento
- Características externas de dínamos; Regulação de tensão
- Paralelo de dínamos e repartição de carga
- Características externas de motores CC
- Regulação de velocidade; Sistemas Ward-Leonard
- Arranque, travagem e inversão de marcha de motores CC ")
elseif lang == "en"
	Foldable("Direct Current (DC) Machine", md"
- Construction, operating principle, excitation types, equivalent circuits
- Power, losses and efficiency
- External characteristics of dynamos; Voltage regulation
- Association of dynamos and load sharing
- External characteristics of DC motors
- Speed regulation; Ward-Leonard systems
- Starting, braking and speed reversing of DC motors ")
end

# ╔═╡ b8c5ca70-be9d-464e-8489-fd41b8445952
if lang == "pt"
	Foldable("Máquina Síncrona (MS) trifásica", md"
- Constituição, princípio funcionamento, esquemas equivalentes
- Determinação de parâmetros (polos lisos, polos salientes)
- Potência, perdas e rendimento
- Características externas de alternador isolado
- Sincronização do alternador com a rede elétrica; Operação nos 4 quadrantes
- Curvas V; Compensador síncrono
- Associação de alternadores em paralelo: regulação de $f$ e $U$ vs. repartição de $P$ e $Q$ ")
elseif lang == "en"
		Foldable("Three-phase Synchronous Machine (SM)", md"
- Construction, operating principle, equivalent circuits
- Parameters determination (cylindrical rotor, salient poles)
- Power, losses and efficiency
- External characteristics of a stand-alone alternator
- Synchronization of alternator with electrical grid; Operation in 4 quadrants
- V-curves; Synchronous condenser	 
- Association of alternators in parallel: regulation of $f$ and $U$ vs. load sharing of $P$ and $Q$ ")
end

# ╔═╡ 90cc6fe9-0a65-4a61-93a2-296c416db981
if lang == "pt"
	Foldable("Transitórios de Máquinas Elétricas (ME)", md"
- Equação mecânica e ensaio de desaceleração\
- Estabilidade da MS\
- Curto-circuito simétrico num alternador em vazio")
elseif lang == "en"
	Foldable("Dynamics of Electrical Machines", md"
- Mechanical equation and deceleration test
- SM stability
- Symmetrical short-circuit in an alternator at no-load ")
end

# ╔═╡ 6538fe16-97a6-4886-8253-2f40593d4d81
if lang == "pt"
	md"# Bibliografia Principal"
elseif lang == "en"
	md"# Main Bibliography"
end

# ╔═╡ fba9f05c-7b5f-4f7c-bcd6-608ff25ff634
begin
	Sahdev = "https://m.media-amazon.com/images/I/41LC-UhrXaL._AC_UF1000,1000_QL80_.jpg"
	Guru = "https://m.media-amazon.com/images/I/71IJTb27FBL._AC_UF1000,1000_QL80_.jpg"
	Sen ="https://pictures.abebooks.com/isbn/9781118078877-us.jpg"
	Matsch = "https://m.media-amazon.com/images/I/51OAtPIq+ML._AC_UF1000,1000_QL80_.jpg"
	
	md"""
| |  |
|:--:|:--|
| $(Resource(Sahdev, :width => 140)) | S. K. Sahdev, Electrical Machines, Cambridge University Press, 2018|
| $(Resource(Guru, :width => 140)) | B.S. Guru, H.R. Hiziroglu, Electric Machinery and Transformers, Oxford Univ. Press, 2001 |	
| $(Resource(Sen, :width => 140))  | P.C. Sen, Principles of electric machines and power electronics, John Wiley & Sons, 1989 |
| $(Resource(Matsch, :width => 140))  | L.W. Matsch, J.D. Morgan, Electromagnetic and Electromechanical Machines, John Wiley & Sons, 1987 |

"""
end

# ╔═╡ 57166d2c-e6c5-4b74-8103-7746e3ace7f2
if lang == "pt"
	md"# Avaliação"
elseif lang == "en"
	md"# Assessment"
end

# ╔═╡ 656887e0-2f78-498a-90ff-eccdab3bc3f5
if lang == "pt"
	md"""
	$\boldsymbol{\mathit{NF}} = 0.45 \times MT+0.50 \times ML+0.05 \times ME$
	
	 $\boldsymbol{\mathit{NF}}$: **Nota Final**\
	 $MT$: Média dos testes (ou nota do exame)\
	 $ML$: Média ponderada dos Trabalhos Laboratoriais $(TL)$\
	 $ME$: Nota da apresentação da Máquina Elétrica Especial $\rm{(MEE)}$
	
	$ML=\frac{\sum\limits_{i=1}^{5} TL_i \times P_i}{\sum\limits_{i=1}^{5} P_i}$
	
	 $P_i$: peso baseado no número de aulas práticas necessárias para cada trabalho
	
	**Componentes facultativas:** $\rm{MEE}$ e $TL_5$.
	"""
elseif lang == "en"
	md"""
	$\boldsymbol{\mathit{FG}}=0.45 \times TA+0.50 \times LA+0.05 \times SM$
	
	 $\boldsymbol{\mathit{FG}}$: **Final Grade**\
	 $TA$: Tests Average (or exam grade)\
	 $LA$: Laboratory Assignments Weighted Average\
	 $SM$: Special Electrical Machine $\rm{(SEM)}$ presentation grade 
	
	$LA=\frac{\sum\limits_{i=1}^{5} LA_i \times W_i}{\sum\limits_{i=1}^{5} W_i}$
	
	 $W_i$: weight based on the number of practical classes required for each assignment
	
	**Optional components:** $\rm{SEM}$ and $LA_5$.
	"""
end

# ╔═╡ cf6d97ec-e94b-4ec8-8b08-2e596b5624a4
if lang == "pt"
   md"# Referências"
elseif lang == "en"
   md"# References"
end

# ╔═╡ f6c8f4cb-66a3-4879-8a17-85c37bab2701
md"""
[^Tidema]: Tidema, [A visual representation of Bloom's revised taxonomy, with indications of possible classroom activities associated with each level.](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Bloom%27s_revised_taxonomy.svg/512px-Bloom%27s_revised_taxonomy.svg.png?20240919191759), [CC BY 4.0](https://creativecommons.org/licenses/by/4.0), via *Wikimedia Commons*.

[^Bezjak_2018]: Sonja Bezjak, April Clyburne-Sherin, Philipp Conzett, Pedro Fernandes, Edit Görögh, Kerstin Helbig, Bianca Kramer, Ignasi Labastida, Kyle Niemeyer, Fotis Psomopoulos, Tony Ross-Hellauer, René Schneider, Jon Tennant, Ellen Verbakel, Helene Brinken, & Lambert Heller. (2018). [The Open Science Training Handbook](https://open-science-training-handbook.gitbook.io/book). [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1212496.svg)](https://doi.org/10.5281/zenodo.1212496)
"""

# ╔═╡ 79b6d4b5-4617-4084-81fe-a06d1c728c06


# ╔═╡ c251fd12-11b6-4649-898d-70dba9f9e976
if lang == "pt"
	md"# Anexo: árvore das ME"
elseif lang == "en"
	md"# Appendix: EM tree"
end

# ╔═╡ 3b3aa8fe-8b09-43e5-8ca6-05860f3044ad
begin
	Tree_en = BlockDiag("""blockdiag {
	"AC machines" -> Induction -> Polyphase, "Single-phase"
	Polyphase -> "Wound rotor", "Squirrel cage" 

	"Single-phase" -> Capacitor, "Shaded pole", "Split phase", "Reluctance start"
	Capacitor -> "Capacitor start", "Permanent capacitor", "Two capacitor           start/run"

	"Permanent capacitor" -> "Multiple speed", "Single speed"

	"AC machines" -> Synchronous -> "Single/Polyphase" -> "Wound field", "Permanent magnet", Reluctance, Hysteresis, "Multiple speed pole  switching"
	"Wound field" -> "Cylindrical Rotor", "Salient Pole Rotor" 

	"AC machines" [color = "lightblue"]


	"DC machines" -> "Separately excited", "Self excited", " Permanent magnet "
	"Self excited" -> Shunt, Series, Compound
	Series -> Universal, "Split field"
	Compound -> "Long shunt", "Short shunt"
	"Long shunt" -> Cumulative, Differential 
	"Short shunt" -> " Cumulative", " Differential" 

	" Permanent magnet " -> "Conventional construction", "Moving coil", "DC torquer"
	"DC machines" [color = "lightyellow"]

  "Electronically              c o n t r o l l e d" -> Steppers , "Synchronous    phase-locked loop", "Variable frequency", "Brushless DC", "Switched reluctance", "Synchronous reluctance"
	Steppers -> "Perm. magnet", "Reluctance ", Hybrid
	"Variable frequency" -> "Synchronous ", "Induction "
	"Synchronous " -> "Wound rotor ", "Perm. magnet "
	"Induction " -> "Stator control", "Rotor control"
	"Brushless DC" -> "Inverter diven", "Electronic  commutation"
	"Electronic  commutation" -> "Trapezoidal", "Sinusoidal"
	"Synchronous reluctance" -> "PM assisteed"
    "Electronically              c o n t r o l l e d"  [color = "lightgreen"]
	
}""")
	if lang == "pt"
		md"Destape (👁) para visualizar..."
	elseif lang == "en"
		md"Click (👁) to view..."
	end
end

# ╔═╡ b1289346-6bbe-46a0-9721-c51acdf6e362
if lang == "pt"
	Foldable("Princípios de funcionamento de ME não convencionais", md"""
			 $(Tree_en)""")
elseif lang == "en"
	Foldable("Operating principles of special electrical machines", md"""
			 $(Tree_en)""")
end

# ╔═╡ a9501886-df7e-4c46-88b7-06e8344b01fd
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
	lang_code = lang == "pt" ? "pt-PT" : lang
	#lang_code = "pt-PT"
	
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

# ╔═╡ 5b3c89b5-a757-4709-9bdb-f3e0feff5da1
if lang == "pt"
   md"# *Notebook*"
elseif lang == "en"
   md"# Notebook"
end

# ╔═╡ bf113704-6d60-4677-901c-79d0125bc3c0
if lang == "pt"
	md"""
	Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [ShortCodes](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html).
	"""
elseif lang == "en"
	md"""
	`Julia` packages documentation: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [ShortCodes](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html).
	"""
end

# ╔═╡ 5d6fbd00-461b-11ef-2a02-cf1ef479864a
#using PlutoUI, PlutoTeachingTools, ShortCodes
#=
Brief description of the used Julia packages:
  - PlutoUI.jl, for interactive sliders
  - PlutoTeachingTools.jl, to enhance the notebook
  - ShortCodes.jl, embedded shortcodes for Pluto notebooks
=#

# ╔═╡ 1f89f453-7484-4f78-8518-1ef4b8b52d82
begin
	version=VERSION
	if lang == "pt"
		md"""
		*Notebook* desenvolvido em `Julia` versão $(version).
		"""
	elseif lang == "en"
		md"""
		Notebook developed in `Julia` version $(version).
		"""
	end
end

# ╔═╡ d1ffe50a-1491-4b03-8c58-f90d41fd3229
if lang == "pt"
	TableOfContents(title="Índice", depth=1)
elseif lang == "en"
	TableOfContents(depth=1)
end

# ╔═╡ 8c3e700e-4db1-4e2e-a0d1-b7c2cf724b74
md"""
|  |  |
|:--:|:--|
|  | This notebook, [ME-II.jl](https://ricardo-luis.github.io/me-2/ME-II.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ Cell order:
# ╟─d3541bae-bcdb-4e58-89ce-3ad5204e5e56
# ╟─399c7a6d-88da-4966-a524-9a00491809a1
# ╟─117c889a-2c0a-4648-befb-4067cb0869a1
# ╟─20e8ef2a-b923-4e9d-86c8-53aafcd2d8e3
# ╟─797e2cea-ff51-43b2-8d5b-29c6740ec9c5
# ╟─4a679083-ab50-414c-b0e7-1c1ca50f53a0
# ╟─6dd8ad18-9069-4500-bc84-51e502d57c37
# ╟─596dca72-e55b-4559-862b-0807defad8a2
# ╟─689fbf6c-8504-4648-a1da-cf5049fa5310
# ╟─dce5565f-b004-489d-827b-b0af02c3cc6b
# ╟─7cda7c65-c1e5-4038-8414-406b30da4675
# ╟─250883b0-68da-46e8-8159-d478587e7c31
# ╟─f0b7a6b5-a87f-4c54-aff8-f23f5c6f726f
# ╟─364d1e59-c671-41ba-9be9-83aa1e167208
# ╟─d6816245-7d61-4136-91f0-e8c480665278
# ╟─689dad68-fd9d-4e6b-8adc-029ca1f08ccc
# ╟─b8c5ca70-be9d-464e-8489-fd41b8445952
# ╟─90cc6fe9-0a65-4a61-93a2-296c416db981
# ╟─b1289346-6bbe-46a0-9721-c51acdf6e362
# ╟─6538fe16-97a6-4886-8253-2f40593d4d81
# ╟─fba9f05c-7b5f-4f7c-bcd6-608ff25ff634
# ╟─57166d2c-e6c5-4b74-8103-7746e3ace7f2
# ╟─656887e0-2f78-498a-90ff-eccdab3bc3f5
# ╟─cf6d97ec-e94b-4ec8-8b08-2e596b5624a4
# ╟─f6c8f4cb-66a3-4879-8a17-85c37bab2701
# ╟─79b6d4b5-4617-4084-81fe-a06d1c728c06
# ╟─c251fd12-11b6-4649-898d-70dba9f9e976
# ╟─3b3aa8fe-8b09-43e5-8ca6-05860f3044ad
# ╟─a9501886-df7e-4c46-88b7-06e8344b01fd
# ╟─5b3c89b5-a757-4709-9bdb-f3e0feff5da1
# ╟─bf113704-6d60-4677-901c-79d0125bc3c0
# ╠═5d6fbd00-461b-11ef-2a02-cf1ef479864a
# ╟─1f89f453-7484-4f78-8518-1ef4b8b52d82
# ╠═d1ffe50a-1491-4b03-8c58-f90d41fd3229
# ╟─8c3e700e-4db1-4e2e-a0d1-b7c2cf724b74

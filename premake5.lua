
project "openal-soft"
	language "C++"
	kind "SharedLib"
	targetname "OpenAL32"

	targetdir "bin/%{cfg.buildcfg}_%{cfg.architecture}"
	objdir "bin-int/%{cfg.buildcfg}_%{cfg.architecture}"

	files {
		"common/**.cpp",
		"common/**.h",

		"al/**.cpp",
		"al/**.h",

		"alc/**.cpp",
		"alc/**.h",

		"hrtf_default.h",
		"config.h",
		"verson.h"
	}

	removefiles {
		"alc/mixer/mixer_neon.cpp",
		"alc/backends/**.cpp",
		"alc/backends/**.h"
	}

	includedirs {
		".",
		"common",
		"al",
		"alc",
		"include"
	}

	filter "configurations:Debug"
		symbols "On"

	filter "configurations:Release"
		defines "NDEBUG"
		optimize "On"

	filter "system:windows"
		systemversion "latest"

		defines {
			"_WIN32",
			"NOMINMAX",
			"_CRT_SECURE_NO_WARNINGS",
			"WIN32",
			"_WINDOWS",
			"AL_BUILD_LIBRARY",
			"AL_ALEXT_PROTOTYPES",
			"OpenAL_EXPORTS",
		}

		-- config
		defines {
			"AL_API=__declspec(dllexport)",
			"ALC_API=__declspec(dllexport)",

			"ALSOFT_EMBED_HRTF_DATA",
			"HAVE__ALIGNED_MALLOC",
			"HAVE_SSE",
			"HAVE_SSE2",
			"HAVE_SSE3",
			"HAVE_SSE4_1",
			"HAVE_WASAPI",
			"HAVE_DSOUND",
			"HAVE_WINMM",
			"HAVE_WAVE",
			"SIZEOF_LONG=4",
			"HAVE_MALLOC_H",
			"HAVE_INTRIN_H",
			"HAVE_GUIDDEF_H",
			"HAVE_CPUID_INTRINSIC",
			"HAVE_SSE_INTRINSICS"
		}

		files {
			"alc/backends/base.cpp",
			"alc/backends/base.h",
			"alc/backends/dsound.cpp",
			"alc/backends/dsound.h",
			"alc/backends/loopback.cpp",
			"alc/backends/loopback.h",
			"alc/backends/null.cpp",
			"alc/backends/null.h",
			"alc/backends/wasapi.cpp",
			"alc/backends/wasapi.h",
			"alc/backends/wave.cpp",
			"alc/backends/wave.h",
			"alc/backends/winmm.cpp",
			"alc/backends/winmm.h"
		}

		links {
			"winmm.lib"
		}

		-- Ignore the following specific warnings
		-- TODO: filter for specifically visual studio
		buildoptions {
			"/w14640",
			"/wd4065",
			"/wd4268",
			"/wd4324",
			"/wd5030",
			"/wd4834"
		 }

	filter {}
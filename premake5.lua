project "Box2D"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    cdialect "C11"
    staticruntime "off"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    
    files
    {
        "src/**.h",
        "src/**.c",
        "include/**.h"
    }
    
    includedirs
    {
        "include",
        "extern/simde"
    } 

    defines {
        "BOX2D_VALIDATE"
    }

    filter "action:vs*"
        buildoptions { "/experimental:c11atomics" }

    filter "system:windows"
        systemversion "latest"
    
    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"
        defines { "DEBUG" }
    
    filter "configurations:Release"
        runtime "Release"
        optimize "on"
        defines { "NDEBUG" }
        
    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        defines { "NDEBUG" }

    filter { "system:windows", "architecture:x86_64", "options:BOX2D_AVX2" }
        defines { "BOX2D_AVX2" }
        buildoptions { "/arch:AVX2" }

    filter { "system:windows", "configurations:Debug", "options:BOX2D_SANITIZE" }
        buildoptions { "/fsanitize=address" }
        linkoptions { "/INCREMENTAL:NO" }

    filter { "system:macosx", "options:BOX2D_SANITIZE" }
        buildoptions { "-fsanitize=address -fsanitize-address-use-after-scope -fsanitize=undefined" }
        linkoptions { "-fsanitize=address -fsanitize-address-use-after-scope -fsanitize=undefined" }

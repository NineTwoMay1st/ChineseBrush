
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
 
Shader "Painting"  
{  
    Properties  
    {  
        _MainTex ("MainTex (RGB) Trans (A)", 2D) = "white" {}  
        _Color ("Color", Color) = (1,1,1,1)  
    }  
  
    SubShader  
    {  
        Tags  
        {   
            "Queue"="Transparent"   
            "IgnoreProjector"="True"   
            "RenderType"="Transparent"   
            "PreviewType"="Plane"  
            "CanUseSpriteAtlas"="True"  
        }  
  
        Cull Off  
        Lighting Off  
        ZWrite Off  
        Fog { Mode Off }  
        Blend One OneMinusSrcAlpha  
  
        Pass  
        {  
            CGPROGRAM  
            #pragma vertex vert  
            #pragma fragment frag  
            #include "UnityCG.cginc"  
  
            struct v2f  
            {  
                float4 vertex : SV_POSITION;  
                half2 texcoord : TEXCOORD0;  
            };  
  
            fixed4 _Color;  
  
            v2f vert(appdata_base IN)  
            {  
                v2f OUT;  
                OUT.vertex = UnityObjectToClipPos(IN.vertex);  
                OUT.texcoord = IN.texcoord;  
                return OUT;  
            }  
  
            sampler2D _MainTex;  
  
            fixed4 frag(v2f IN) : SV_Target  
            {  
                float4 col = _Color * tex2D(_MainTex, IN.texcoord);  
                col.rgb *= col.a;  
                return col;  
            }  
            ENDCG  
        }  
    }  
} 
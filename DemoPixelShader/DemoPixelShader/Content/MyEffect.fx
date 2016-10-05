#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

matrix WorldViewProjection;

texture HinhTuSpriteBatch;

sampler TextureSampler = sampler_state
{
	Texture = <HinhTuSpriteBatch>;
};


struct VertexShaderInput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
};

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
};

VertexShaderOutput MainVS(in VertexShaderInput input)
{
	VertexShaderOutput output = (VertexShaderOutput)0;

	output.Position = mul(input.Position, WorldViewProjection);
	output.Color = input.Color;

	return output;
}

float4 MainPS(float2 texCoordinates: TEXCOORD0) : COLOR
{
//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1- (texCoordinates+1)/2;
	TextureCoordinates.x = 1-TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	return color;

}

technique BasicColorDrawing
{
	pass P0
	{
//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};

float4 MainPS1(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	color.rgb = color.r*0.3 + color.g*0.59 + color.b * 0.11;
	return color;

}


technique Technique01
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS1();
	}
};



float4 MainPS2(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	color.rgb = color.r*0.3 + color.g*0.59 + color.b * 0.11;
	color.r *= 1.1;
	color.g *= 1.2;
	color.b *= 0.8;
	return color;

}


technique Technique02
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS2();
	}
};

float t;


float4 MainPS3(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;

	

	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates) +
		tex2D(TextureSampler, TextureCoordinates + float2(t, 0)) +
		tex2D(TextureSampler, TextureCoordinates + float2(-t, 0)) +
		tex2D(TextureSampler, TextureCoordinates + float2(0, t)) +
			tex2D(TextureSampler, TextureCoordinates + float2(0, -t));
	color /= 5;

	return color;

}


technique Technique03
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS3();
	}
};



float4 MainPS4(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = float4(
		tex2D(TextureSampler, TextureCoordinates).r,
		tex2D(TextureSampler, TextureCoordinates + float2(0.01, 0)).gb, 
		1);

	return color;

}


technique Technique04
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS4();
	}
};



float4 MainPS5(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color =
		(
			 tex2D(TextureSampler, TextureCoordinates - float2(0.001, 0))
			-tex2D(TextureSampler, TextureCoordinates + float2(0.001, 0))
		) / 2 
			+ 0.5;

	color.r *= 1.2;
	color.g *= 1.1;
	color.b *= 0.8;
	color.a = 1;

	return color;

}


technique Technique05
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS5();
	}
};


float4 MainPS6(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;

	tex2D(TextureSampler, TextureCoordinates + 0.01*float2(sin(TextureCoordinates.x*63), 0))
	color =
		(
			tex2D(TextureSampler, TextureCoordinates -	 float2(sin(t)*0.001, cos(t)*0.001))
			- tex2D(TextureSampler, TextureCoordinates + float2(sin(t)*0.001, cos(t)*0.001))
			) / 2
		+ 0.5;

	color.r *= 1.2;
	color.g *= 1.1;
	color.b *= 0.8;
	color.a = 1;

	return color;

}


technique Technique06
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS6();
	}
};
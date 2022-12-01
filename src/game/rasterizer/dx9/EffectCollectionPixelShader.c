typedef struct {
    int pixel_shader_function_name_size;
    char pixel_shader_function_name[?];
    int dx9_byte_code_size[?];
    char dx9_byte_code[?];
} Shader;

typedef struct {
    int shader_name_size;
    char shader_name[?];
    int shader_count;
    Shader shaders[?];
} Effect;

typedef struct {
    int version; // probably it's just a magic number, the game does not care about it
    Effect collection[?];
    char checksum[32];
    char valid[1];
} EffectCollectionPixelShader;

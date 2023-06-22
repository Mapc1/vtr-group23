layout (location = 0) out vec4 out_pos;

uniform int N_OCTAVES = 3; 

in vec4 nn;
in vec4 pos;

void main() {
    float frequency = 1;
    float amplitude = 0.25;
    float lacunarity = 2.0;
    float persistence = 0.5;

    float n = 0;

    for (int octave = 0; octave < N_OCTAVES; octave++) {
        n += amplitude * cnoise(frequency*pos);
        frequency *= lacunarity;
        amplitude *= persistence;
    }
    if (n < 0)
        n = 0;
        
    float frequency_l2 = 3.5;
    float amplitude_l2 = 3;
    float lacunarity_l2 = 2.0;
    float persistence_l2 = 0.5;

    float n2 = amplitude_l2 * cnoise(frequency*pos);
    if (n2 > 0.2)
        n *= n2;
    out_pos = pos * 0.5 + 0.5; // + n * nn;
}
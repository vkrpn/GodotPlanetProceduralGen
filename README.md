A planet is generated from these values:

Noise frequency: the intensity of the Perlin noise that is used to generate terrain

Amplitude: the intensity of the effect that the Perlin noise has on elevation

Radius: planet radius

Radial segments: the sphere's radial segments. This is essentially resolution. The higher the value, the higher the detail the terrain has. I do not recommend settings a value above 2048.

Sphere rings: the sphere's rings. This value is similar to radial segments. I recommend settings this value to half of the radial segments value. I do not recommend settings a value above 1024.

Colors 1-4: colors of terrain. Color 1 is lowest elevation terrain color, and Color 4 is highest elevation terrain color (RGBA separated by commas, like this: 1,1,1,1)

Cloud color: the color of the clouds (RGBA separated by commas, like this: 1,1,1,1)

Once you input those values, the code creates a sphere with the radial segments and rings you specified. Then, the brand new sphere is converted into an array mesh with editable vertexes.
A for loop modifies the height of each vertex based on amplitude, noise, and radius (radius + noise * amplitude). Then, based on the noise value, each vertex is assigned one of four colors determined by elevation. This is repeated a second time, however this time there are 2 colors: the cloud color, and transparent, to generate clouds. After all of that, your planet is generated. Please be patient, the generator can take a while, especially at higher radial segment and sphere ring values.

The planet can be rotated with WASD/arrow keys and you can use the mouse wheel or the +/- keys to zoom.

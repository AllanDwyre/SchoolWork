#include "image_ppm.h"
#include <stdio.h>
/*===========================================================================*/
/*===========================================================================*/

int getIndice(int u, int v, int width)
{
	return u + v * width;
}

int getIndiceRed(int u, int v, int width)
{
	return getIndice(u, v, width) * 3;
}
int getIndiceGreen(int u, int v, int width)
{
	return getIndice(u, v, width) * 3 + 1;
}
int getIndiceBlue(int u, int v, int width)
{
	return getIndice(u, v, width) * 3 + 2;
}
/*===========================================================================*/
/*===========================================================================*/

bool isImageBorder(int u, int v, int witdh, int height)
{
	return u == 0 || v == 0 || u == (witdh - 1) || v == (height - 1);
}

/*===========================================================================*/
/*===========================================================================*/

int getColor(OCTET *pt_image, int channel, int u, int v, int width)
{
	if(channel == 1)
		return pt_image[getIndiceRed(u, v, width)];
	if(channel == 2)
		return pt_image[getIndiceGreen(u, v, width)];
	if(channel == 3)
		return pt_image[getIndiceBlue(u, v, width)];
	return pt_image[getIndice(u, v, width)];
}

void setColor(OCTET *pt_image, int value, int u, int v, int width, int channel = 0)
{
	if(channel == 1)
		pt_image[getIndiceRed(u, v, width)] = value;
	else if(channel == 2)
		pt_image[getIndiceGreen(u, v, width)] = value;
	else if(channel == 3)
		pt_image[getIndiceBlue(u, v, width)] = value;
	else
		pt_image[getIndice(u, v, width)] = value;
}
/*===========================================================================*/
/*===========================================================================*/

// histograme have to be free to prevent leak of memory.
int* buildHisto(OCTET *pt_image, int width, int height, int channel = 0)
{
	int* histograme = (int*)calloc(255, sizeof(int));

	for (int u=0; u < width; u++)
	{
		for (int v=0; v < height; v++)
		{
			histograme[getColor(pt_image, channel, u, v, width)]++;
		}
	}
	return histograme;
}

int** buildHistoColor(OCTET *pt_image, int width, int height)
{
	int** histogrames = (int**)calloc(3,255 * sizeof(int));
	histogrames[0] = buildHisto(pt_image, width, height, 1);
	histogrames[1] = buildHisto(pt_image, width, height, 2);
	histogrames[2] = buildHisto(pt_image, width, height, 3);

	return histogrames;
}

void printHisto(int* histograme)
{
	for (int i=0; i < 255; i++)
	{
		printf("%i %i\n", i, histograme[i]);
	}
}
void printHistoColor(int** histogrames)
{
	for (int i=0; i < 255; i++)
	{
		printf("%i %i %i %i\n", i, histogrames[0][i], histogrames[1][i], histogrames[2][i]);
	}
}
/*===========================================================================*/
/*===========================================================================*/


// profile have to be free to prevent leak of memory.
int* buildProfile(OCTET *pt_image, int pos, bool isLine, int width, int height, int channel = 0)
{
	int linelenght = isLine ? width : height;

	int* profil = (int*)calloc(linelenght, sizeof(int));

	for (int i=0; i < linelenght; i++)
	{
		int grey = isLine ? getColor(pt_image, channel, i, pos, height) : getColor(pt_image, channel, pos, i, width);
		profil[i] = grey;
	}
	return profil;
}


/*===========================================================================*/
/*===========================================================================*/


OCTET* buildSeuilImage(OCTET *pt_image, int seuil, bool haveColor, int width, int height)
{
	int taille = haveColor ? width * height * 3 : width * height;
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, taille);

	for (int i = 0; i < taille; i++)
	{
		int nR = pt_image[i];
		int nG = pt_image[i+1];
		int nB = pt_image[i+2];
		if (nR < seuil) ImgOut[i]=0; else ImgOut[i]=255;
		if (nG < seuil) ImgOut[i+1]=0; else ImgOut[i+1]=255; 
		if (nB < seuil) ImgOut[i+2]=0; else ImgOut[i+2]=255;
	}

	return ImgOut;
}

OCTET* buildSeuilImage(OCTET *pt_image, int seuilR, int seuilG, int seuilB, bool haveColor, int width, int height)
{
	int taille = haveColor ? width * height * 3 : width * height;
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, taille);

	for (int i = 0; i < taille; i++)
	{
		int nR = pt_image[i];
		int nG = pt_image[i+1];
		int nB = pt_image[i+2];
		if (nR < seuilR) ImgOut[i]=0; else ImgOut[i]=255;
		if (nG < seuilG) ImgOut[i+1]=0; else ImgOut[i+1]=255; 
		if (nB < seuilB) ImgOut[i+2]=0; else ImgOut[i+2]=255;
	}

	return ImgOut;
}

/*===========================================================================*/
/*===========================================================================*/

bool isWhite(int color){
	return color == 255;
}
bool isBlack(int color){
	return color == 0;
}
/*===========================================================================*/
/*===========================================================================*/

/// Need a grey image, and must free the return array
/// erosion, white expand
OCTET* buildErrosion(OCTET *pt_image, bool (*pattern)(OCTET*, int, int, int, bool), int width, int height)
{
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, width * height);

	for (int u=0; u < width; u++)
	{
		for (int v=0; v < height; v++)
		{
			if(isImageBorder(u, v, width, height) || isWhite(getColor(pt_image, 0, u, v, width)))
			{
				ImgOut[getIndice(u,v,width)] = getColor(pt_image, 0, u, v, width); // unchanged color if is border
				continue;
			}

			ImgOut[getIndice(u, v, width)] = pattern(pt_image, u, v, width, true) * 255;
		}
	}

	return ImgOut;
}

/// Need a grey image, and must free the return array, normally wit croix pattern
/// Dilatation black expand
OCTET* buildDilatation(OCTET *pt_image, bool (*pattern)(OCTET*, int, int, int, bool), int width, int height)
{
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, width * height);

	for (int u=0; u < width; u++)
	{
		for (int v=0; v < height; v++)
		{
			if(isImageBorder(u, v, width, height) || isBlack(getColor(pt_image, 0, u, v, width)))
			{
				ImgOut[getIndice(u,v,width)] = getColor(pt_image, 0, u, v, width);
				continue;
			}

			ImgOut[getIndice(u,v,width)] = pattern(pt_image, u, v, width, true) ? 255 : 0;
		}
	}

	return ImgOut;
}

bool CustomPattern(OCTET* imageIn, int* mask, int maskW, int maskH, bool allOnly, int u, int v, int width)
{
	int res = 0;
	for (int umask = 0; umask  < maskW; umask ++)
	{
		for (int vmask = 0; vmask < maskH; vmask++)
		{
			if (mask[getIndice(umask, vmask, maskW)])
			{
				int color = getColor(imageIn, 0, u + umask, v + vmask, width);
				res = allOnly ? color * res : color + res;
			}
		}
	}
	return res >= 255;
}
/*
-  *  pattern
- ***
-  * 
*/
bool CroixPattern(OCTET* imageIn, int u, int v, int width, bool allOnly = true)
{
	int croix[9] = 
	{
		0, 1, 0,
		1, 1, 1,
		0, 1, 0
	};
	return CustomPattern(imageIn, croix, 3, 3, true, u, v, width);
}
/*
- *** pattern
- ***
- ***
*/
bool SquarePattern(OCTET* imageIn, int u, int v, int width, bool allOnly = true)
{
	int res = 0;
	for (int i=0; i < 9; i++)
	{
		int uOffset = i % 3 - 1;
		int vOffset = i / 3 - 1;
		int color = getColor(imageIn, 0, u + uOffset, v + vOffset, width);
		res = allOnly ? res * color : res + color;
	}
	return res >= 255;
}

/*===========================================================================*/
/*================================channel===========================================*/

OCTET* buildInverse(OCTET *pt_image, int width, int height)
{
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, width * height);

	for (int i=0; i < width; i++)
	{
		ImgOut[i] = 255 - pt_image[i];
	}

	return ImgOut;
}

/*===========================================================================*/
/*===========================================================================*/

// La fermeture d’une image binaire consiste à enchainer une dilatation et une érosion sur l’image
// binaire. Cela permet de boucher des trous dans les objets contenus dans l’image binaire.
// L’ouverture d’une image binaire consiste à enchainer une érosion et une dilatation sur l’image
// binaire. Cela permet de supprimer des points parasites du fond de l’image binaire.

OCTET* buildFermeture(OCTET *pt_image, int width, int height)
{
	bool (*pattern)(OCTET*, int, int, int, bool) = CroixPattern;
	OCTET *Imgtmp = buildDilatation(pt_image, pattern, width, height);
	OCTET *ImgOut = buildErrosion(Imgtmp, pattern, width, height);
	free(Imgtmp);
	return ImgOut;
}

OCTET* buildOuverture(OCTET *pt_image, int width, int height)
{
	bool (*pattern)(OCTET*, int, int, int, bool) = CroixPattern;
	OCTET *Imgtmp = buildErrosion(pt_image, pattern, width, height);
	OCTET *ImgOut = buildDilatation(Imgtmp, pattern, width, height);
	free(Imgtmp);
	return ImgOut;
}

/*===========================================================================*/
/*===========================================================================*/

OCTET* buildDifference(OCTET *a, OCTET *b, int width, int height, int channel = 0)
{
	OCTET *ImgOut;
	allocation_tableau(ImgOut, OCTET, width * height);

	for (int u=0; u < width; u++)
	{
		for (int v=0; v < height; v++)
		{
			if(getColor(a, channel, u, v, width) == getColor(b, channel, u, v, width))
				setColor(ImgOut, 255, u, v, width, channel);
			else
				setColor(ImgOut, 0, u, v, width, channel);
		}
	}

	return ImgOut;
}

/*===========================================================================*/
/*===========================================================================*/

// int Normalise(int u, int v)
// {
// 	return sqrt(pow(u,2) + pow(v, 2));
// }

// OCTET* normeGradient(OCTET *pt_image,int width, int height, int channel = 0)
// {
// 	OCTET *ImgOut;
// 	allocation_tableau(ImgOut, OCTET, width * height);

// 	for (int u=0; u < width; u++)
// 	{
// 		for (int v=0; v < height; v++)
// 		{
// 			int gradientX = getColor(pt_image, channel, u, v, width) - getColor(pt_image, channel, (u + 1) % width, v, width);
// 			int gradientY = getColor(pt_image, channel, u, v, width) - getColor(pt_image, channel, u, (v + 1) % height, width);
// 			setColor(ImgOut, Normalise(gradientX, gradientY), u, v, width);
// 		}
// 	}
// 	return ImgOut;
// }
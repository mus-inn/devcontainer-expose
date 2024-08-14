<?php

namespace App\Server\SubdomainGenerator;

use App\Contracts\SubdomainGenerator;

class RandomSubdomainGenerator implements SubdomainGenerator
{
    protected $adjectives = [
        'bleu',
        'rouge',
        'vert',
        'jaune',
        'rapide',
        'lent',
        'fou',
        'sage',
        'bruyant',
        'silencieux',
        'grand',
        'petit',
        'sombre',
        'clair',
        'fort',
        'faible',
        'heureux',
        'triste',
        'jeune',
        'vieux'
    ];

    protected $nouns = [
        'chien',
        'chat',
        'lion',
        'tigre',
        'soleil',
        'lune',
        'étoile',
        'montagne',
        'rivière',
        'océan',
        'arbre',
        'fleur',
        'oiseau',
        'poisson',
        'nuage',
        'vent',
        'feu',
        'glace',
        'rocher',
        'forêt'
    ];

    public function generateSubdomain(): string
    {
        $adjective = $this->adjectives[array_rand($this->adjectives)];
        $noun = $this->nouns[array_rand($this->nouns)];

        return strtolower($adjective . '-' . $noun);
    }
}

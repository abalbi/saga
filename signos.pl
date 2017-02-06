our $signos = {
  aries => {
    orden => 1,
    compatibilidad => [qw(4 3 4 3 5 1 2 2 5 2 4 1)],
    elemento => 'fire',
    lema => 'Yo soy',
    virtudes => [qw(
      pioner[a|o]
      ejecutiv[a|o]
      emprendedor[a|]
      direct[a|o]
      energic[a|o]
      guerrer[a|o]
      valiente
    )],
    defectos => [qw(
      egoista
      agresiv[a|o]
      impulsiv[a|o]
      irreflexiv[a|o]
      altaner[a|o]
      dominante
      inconstante
    )],
  },
  taurus => {
    orden => 2,
    compatibilidad => [qw(3 5 1 4 3 5 2 2 1 5 2 4)],
    elemento => 'earth',
    lema => 'Yo tengo',
    virtudes => [qw(
      afectuos[a|o]
      estable
      paciente
      reflexiv[a|o]
      imperturbable
      tenaz
      sensual
    )],
    defectos => [qw(
      brutal
      lent[a|o]
      materialista
      obstinad[a|o]
      posesiv[a|o]
      terc[a|o]
      tedios[a|o]
    )],
  },
  gemini => {
    orden => 3,
    compatibilidad => [qw(4 1 5 1 4 2 5 1 3 2 5 1)],
    elemento => 'air',
    lema => 'Yo pienso',
    virtudes => [qw(
      comunicativ[a|o]
      elocuente
      versatil
      intelectual
      amigable
      polifacetic[a|o]
      ingenios[a|o]
    )],
    defectos => [qw(
      curios[a|o]
      nervios[a|o]
      superficial
      inconstante
      chismos[a|o]
      parlanchin
      dispers[a|o]
    )],
  },
  cancer => {
    orden => 4,
    compatibilidad => [qw(2 4 3 5 3 4 1 5 2 4 2 5)],
    elemento => 'water',
    lema => 'Yo siento',
    virtudes => [qw(
      hogareni[a|o]
      maternal
      nutritiv[a|o]
      romantic[a|o]
      emotiv[a|o]
      sensible
      familiar
    )],
    defectos => [qw(
      contradictori[a|o]
      repetitiv[a|o]
      indirect[a|o]
      lloron[a|]
      susceptible
      timid[a|o]
      vulnerable
    )],
  },
  leo => {
    orden => 5,
    compatibilidad => [qw(5 3 4 3 5 1 4 3 5 2 2 3)],
    elemento => 'fire',
    lema => 'Yo hago',
    virtudes => [qw(
      creativ[a|o]
      lider
      elegante
      estratega
      organizador[a|]
      valiente
      noble
    )],
    defectos => [qw(
      soberbi[a|o]
      dominante
      dramatic[a|o]
      orgullos[a|o]
      exhibicionista
      fanfarron[a|]
      prepotente
    )],
  },
  virgo => {
    orden => 6,
    compatibilidad => [qw(1 5 2 4 1 5 2 4 1 5 2 2)],
    elemento => 'earth',
    lema => 'Yo analizo',
    virtudes => [qw(
      estudios[a|o]
      detallista
      ordenad[a|o]
      pulcr[a|o]
      servicial
      analitic[a|o]
      diligente
    )],
    defectos => [qw(
      aprensiv[a|o]
      critic[a|o]
      quisquillos[a|o]
      escrupulos[a|o]
      exigente
      perfeccionista
      intolerante
    )],
  },
  libra => {
    orden => 7,
    compatibilidad => [qw(3 3 5 1 4 2 5 2 4 2 5 3)],
    elemento => 'air',
    lema => 'Yo busco',
    virtudes => [qw(
      diplomatic[a|o]
      just[a|o]
      refinad[a|o]
      pacific[a|o]
      sutil
      estetic[a|o]
      gentil
    )],
    defectos => [qw(
      indecis[a|o]
      comod[a|o]
      dulcer[a|o]
      desorientad[a|o]
      insegur[a|o]
      caprichos[a|o]
      acomodatici[a|o]
    )],
  },
  scorpius => {
    orden => 8,
    compatibilidad => [qw(3 3 1 5 3 4 2 5 2 4 2 5)],
    elemento => 'water',
    lema => 'Yo deseo',
    virtudes => [qw(
      agud[a|o]
      magnetic[a|o]
      apasionad[a|o]
      perspicaz
      profund[a|o]
      secretiv[a|o]
      astut[a|o]
    )],
    defectos => [qw(
      celos[a|o]
      sexual
      misterios[a|o]
      extremista
      vengativ[a|o]
      violent[a|o]
      obsesiv[a|o]
    )],
  },
  sagittarius => {
    orden => 9,
    compatibilidad => [qw(5 1 3 2 5 1 4 2 5 1 4 2)],
    elemento => 'fire',
    lema => 'Yo veo',
    virtudes => [qw(
      afortunad[a|o]
      alegre
      expansiv[a|o]
      filosofic[a|o]
      generos[a|o]
      optimista
      sincer[a|o]
    )],
    defectos => [qw(
      autoritari[a|o]
      descuidad[a|o]
      exagerad[a|o]
      irresponsable
      parrander[a|o]
      confianzud[a|o]
      amiguer[a|o]
    )],
  },
  capricornus => {
    orden => 10,
    compatibilidad => [qw(3 5 2 4 2 5 2 4 1 5 2 4)],
    elemento => 'earth',
    lema => 'Yo utilizo',
    virtudes => [qw(
      discret[a|o]
      eficiente
      estructurad[a|o]
      perseverante
      responsable
      seri[a|o]
      planificador[a|]
    )],
    defectos => [qw(
      ambicios[a|o]
      calculador[a|]
      solirati[a|o]
      fri[a|o]
      manipulador[a|]
      pesimista
      sever[a|o]
    )],
  },
  aquarius => {
    orden => 11,
    compatibilidad => [qw(4 2 5 2 2 2 5 2 4 2 5 3)],
    elemento => 'air',
    lema => 'Yo conosco',
    virtudes => [qw(
      fraternal
      humanitari[a|o]
      reformador[a|]
      inventiv[a|o]
      innovador[a|]
      progresista
      independiente
    )],
    defectos => [qw(
      excentric[a|o]
      sabelotod[a|o]
      utopic[a|o]
      inconvencional
      desapegad[a|o]
      rebelde
      revolucionari[a|o]
    )],
  },
  pisces => {
    orden => 12,
    compatibilidad => [qw(1 4 1 5 3 2 3 5 2 4 3 5)],
    elemento => 'water',
    lema => 'Yo creo',
    virtudes => [qw(
      compasiv[a|o]
      mistic[a|o]
      sacrificad[a|o]
      piados[a|o]
      tolerante
      humilde
      intuitiv[a|o]
    )],
    defectos => [qw(
      confus[a|o]
      evasiv[a|o]
      imprecis[a|o]
      soñador[a|]
      fanatic[a|o]
      vicios[a|o]
      credul[a|o]
    )],
  },
};

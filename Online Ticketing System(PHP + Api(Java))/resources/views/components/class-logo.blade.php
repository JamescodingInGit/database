@if($class == 'U')
    <img class="classIMG" src="{{ asset('image/U.png') }}" alt="classLogo">
@elseif ($class == 'P12')
    <img class="classIMG" src="{{ asset('image/p12.png') }}" alt="classLogo">
@elseif ($class == 'P13')
    <img class="classIMG" src="{{ asset('image/p13.png') }}" alt="classLogo">
@elseif ($class == '16')
    <img class="classIMG" src="{{ asset('image/16.png') }}" alt="classLogo">
@else
    <img class="classIMG" src="{{ asset('image/18.png') }}" alt="classLogo">
@endif
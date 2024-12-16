<?php
namespace App\Decorators;

use App\Models\User;

class UserDecorator
{
    protected $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }

    // Method to format the full name (for example)
    public function getFullName()
    {
        return ucwords($this->user->name);
    }

    // Add additional functionality like formatting dates
    public function getFormattedDateOfBirth()
    {
        return $this->user->DOB ? $this->user->DOB->format('d F Y') : 'N/A';
    }

    // Decorate any other functionality
    public function getProfileData()
    {
        return [
            'name' => $this->getFullName(),
            'email' => $this->user->email,
            'mobileNo' => $this->user->mobileNo,
            'DOB' => $this->getFormattedDateOfBirth(),
        ];
    }

    // Add any other extra behavior you want to extend for user data
}

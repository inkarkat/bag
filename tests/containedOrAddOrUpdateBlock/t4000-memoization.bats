#!/usr/bin/env bats

load temp

@test "asks again on confirm each" {
    export MEMOIZEDECISION_CHOICE=c
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]

    cp -f "$FRESH" "$FILE"  # Restore original file.
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]
}

@test "recalls positive choice on yes" {
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]

    cp -f "$FRESH" "$FILE"  # Restore original file.
    MEMOIZEDECISION_CHOICE=
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Will\ update\ it\ now\. ]]
}

@test "does not recall another file on yes" {
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]

    MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE2"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE2")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]
}

@test "recalls another file on any" {
    export MEMOIZEDECISION_CHOICE=a
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE")\ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]

    MEMOIZEDECISION_CHOICE=n
    run containedOrAddOrUpdateBlock --memoize-group containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE2"
    [ $status -eq 0 ]
    [[ "$output" =~ $(basename "$FILE2")\ does\ not\ yet\ contain\ test\.\ Will\ update\ it\ now\. ]]
}
